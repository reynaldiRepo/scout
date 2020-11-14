<?php

use SilverStripe\Security\Member;
use SilverStripe\Admin\SecurityAdmin;
use SilverStripe\Admin\LeftAndMainExtension;
use SilverStripe\Forms\FieldList;
use Plastyk\Dashboard\Admin\DashboardAdmin;
use SilverStripe\ORM\DataObject;
use SilverStripe\ORM\DB;
use SilverStripe\ORM\ArrayList;


class DashboardAdminExtension extends LeftAndMainExtension{
    public function init(){
        parent::init();
        // for update vpath
        // $jsonPath =  "../app/src/JSON/vmap.json";
        // $strJson = file_get_contents($jsonPath);
        // $array = json_decode($strJson, true);   
        // foreach($array as $k=>$v ){
        //     $kab = DataObject::get('KabupatenData', "Title Like '%".$v['name']."%' and ProvinsiDataID = '".ProvinsiData::getJatim()->ID."'")->first();
        //     $kab->PathVmap = $k;
        //     $kab->write();
        // }
        // die("success");
    }

    private static $allowed_actions = [
        'exportmemberbysakakwarcab'
    ];

    public function rand_color() {
        return 'rgba('.rand(120,255).','.rand(120,255).','.rand(120,255).', 0.8)';
    }


    public function colorSaka(){
        $res = [];
        foreach(SakaData::get() as $s){
            $res[$s->Title] = $this->rand_color();
        }
        return $res;
    }

    public function getNumMemberSakaByPlace(){
        $sql = "SELECT MemberData.ID, KabupatenData.Title as 'Title1', SakaData.Title as 'Title2' FROM MemberData, Member, KabupatenData, SakaData
        WHERE MemberData.SakaDataID = SakaData.ID AND Member.ID = MemberData.ID AND KabupatenData.ID = Member.KwarcabID";
        $res = DB::query($sql);
        $result = [];
        foreach($res as $r){
            if (isset($result[$r['Title1']][$r['Title2']] )){
                $result[$r['Title1']][$r['Title2']]['Jumlah'] += 1;
            }else{
                $result[$r['Title1']][$r['Title2']]['Jumlah'] = 1;
            }
        }
        $arrayList = new ArrayList();
        foreach($result as $k => $v){
            $temp =[];
            $temp['Kota'] = $k;
            $temp['Saka'] = new ArrayList();
            $temp['Color'] = $this->rand_color();
            foreach($v as $k=>$v){
                $temp2 = [];
                $temp2['Title'] = $k;
                $temp2['Jumlah'] = $v['Jumlah'];
                $temp['Saka']->push($temp2);
            }
            $arrayList->push($temp);
        }
        return $arrayList;
        
    }

    public function getNumMemberByPlace($idPlace = null){
        if ($idPlace == null){
            $sql = "SELECT COUNT(MemberData.ID) as 'Jumlah', KabupatenData.Title FROM MemberData, Member, KabupatenData
            WHERE MemberData.ID = Member.ID AND KabupatenData.ID = Member.KwarcabID
            Group BY Member.KwarcabID";
            $res = DB::query($sql);
            $result = new ArrayList();
            foreach($res as $r){
                $r['Color'] = $this->rand_color();
                if ($r['Jumlah'] != 0) {
                    $result->push($r);
                }
            }
            return $result;
        }
    }

    public function getNumMemberByKab(){
        $data = new ArrayList();
        $kab = CT::getKabupatenJatim();
        foreach ($kab as $k){
            $member = MemberData::get()->filter(['KwarcabID'=>$k->ID])->count();
            if ($member) {
                $data->push(['path'=>$k->PathVmap, 'jumlah'=>$member, 'color'=>$this->rand_color()]);
            }else{
                $data->push(['path'=>$k->PathVmap, 'jumlah'=>0, 'color'=>$this->rand_color()]);
            }
        }
        return $data;
    }

    public function getNumMemberBySaka(){
        $sql = "SELECT COUNT(MemberData.ID) as 'Jumlah', SakaData.Title FROM MemberData, Member, SakaData
        WHERE MemberData.ID = Member.ID AND SakaData.ID = MemberData.SakaDataID
        Group BY MemberData.SakaDataID";
        $res = DB::query($sql);
        $result = new ArrayList();
        foreach($res as $r){
            $r['Color'] = $this->rand_color();
            if ($r['Jumlah'] != 0) {
                $result->push($r);
            }
        }
        return $result;
    }

    public function getNumMemberByGolongan(){
        $sql = "SELECT COUNT(MemberData.ID) as 'Jumlah', GolonganData   .Title FROM MemberData, Member, GolonganData
        WHERE MemberData.ID = Member.ID AND GolonganData.ID = MemberData.GolonganDataID
        Group BY MemberData.GolonganDataID";
        $res = DB::query($sql);
        $result = new ArrayList();
        foreach($res as $r){
            $r['Color'] = $this->rand_color();
            if ($r['Jumlah'] != 0) {
                $result->push($r);
            }
        }
        return $result;
    }

    public function getLastEvent($limit = 3){
        // var_dump(EventData::get());
        // die();
        return EventData::get()->limit($limit);
    }

    public function getMsgAdmin(){
        $member = Member::currentUser();
        if ($member->inGroup(CT::getGroupID("admin-cabang")->ID)){
            return "Pada sistem ini anda bisa melakukan managerial data member untuk 
                    Kwarcab anda (".$member->Kwarcab()->Title.") dan melakukan import data member";
        }else{
            return "Pada sistem ini anda bisa melakukan managerial data member,
            Event, admin cabang dan data lainnya.";
        }
    }

    public function getDate(){
        return date("d F Y");
    }

    public function getNMember(){
        return MemberData::get()->count();
    }

    public function getNEvent(){
        return EventData::get()->count();
    }

    public function getAdminCabang(){
        return AdminCabangData::get()->count();
    }


    public function getKabJatim(){
        return CT::getKabupatenJatim();
    }

    public function getSakaList(){
        return DataObject::get('SakaData', "Title not Like '%-%' OR Title != ''");
    }

    public function countMemberBySakaKwarcab($kwarcabID){
        $res = new ArrayList();
        foreach($this->getSakaList() as $Saka){            
            $c = MemberData::get()->filter(['SakaDataID'=>$Saka->ID, 'KwarcabID'=>$kwarcabID])->count();
            $res->push(['jumlah'=>$c]);
        }
        return $res;
    }

    public function exportmemberbysakakwarcab(){
        header('Content-Type: text/csv');
        header('Content-Disposition: attachment; filename="member.csv"');

        $user_CSV[0] = array('Kabupaten');
        foreach ($this->getSakaList() as $Saka) {
           array_push($user_CSV[0], $Saka->getTitleShort());
        }        
        

        // very simple to increment with i++ if looping through a database result 
        $index = 1;
        foreach ($this->getKabJatim() as $Kab) {
            $user_CSV[$index] = [$Kab->getTitleShort()];
            foreach ($this->getSakaList() as $Saka) {
                $c = MemberData::get()->filter(['SakaDataID'=>$Saka->ID, 'KwarcabID'=>$Kab->ID])->count();
                array_push($user_CSV[$index], $c);
            }
            $index += 1;
        }

        $fp = fopen('php://output', 'wb');
        foreach ($user_CSV as $line) {
            // though CSV stands for "comma separated value"
            // in many countries (including France) separator is ";"
            fputcsv($fp, $line, ',');
        }
        fclose($fp);
    }
}