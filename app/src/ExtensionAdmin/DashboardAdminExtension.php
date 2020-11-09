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
    }

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
}