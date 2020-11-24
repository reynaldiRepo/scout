<?php
use SilverStripe\ORM\DataObject;
use SilverStripe\ORM\DB;
use SilverStripe\Control\HTTPRequest;
use SilverStripe\Control\HTTPResponse;
use SilverStripe\Control\HTTPResponse_Exception;
use SilverStripe\Assets\Upload;

class ApiHelperPage extends Page{
    
}

class ApiHelperPageController extends PageController{
    /**
     * Defines methods that can be called directly
     * @var array
     */
    private static $allowed_actions = [
        'getProvinsi' => true,
        'getKabupaten' => true,
        'getKecamatan' => true,
        'uploadimage',
        'deleteimage'
    ];
    
    function index(HTTPRequest $request){
        die("/404- Not Allowed");
    }

    function getProvinsi(){
        $prov = ProvinsiData::get()->sort("Title", "ASC");
        $res = [];
        foreach($prov as $p){
            array_push($res, $p->toJsonArray());
        }
        echo json_encode($res);
        return; 
    }

    function getKabupaten(){
        $idprov = isset($_GET['idprov']) ? $_GET['idprov'] : null;
        if ($idprov != null){
            $prov = KabupatenData::get()->filter(["ProvinsiDataID"=>$idprov])->sort("Title", "ASC");
        }else{
            $prov = KabupatenData::get()->sort("Title", "ASC");
        }
        $res = [];
        foreach($prov as $p){
            array_push($res, $p->toJsonArray());
        }
        echo json_encode($res);
        return; 
    }

    function getKecamatan(){
        $idkab = isset($_GET['idkab']) ? $_GET['idkab'] : null;
        if ($idkab != null){
            $prov = KecamatanData::get()->filter(["KabupatenDataID"=>$idkab])->sort("Title", "ASC");
        }else{
            $prov = KecamatanData::get()->sort("Title", "ASC");
        }
        $res = [];
        foreach($prov as $p){
            array_push($res, $p->toJsonArray());
        }
        echo json_encode($res);
        return; 
    }

    public function uploadimage($data){
        $newImage = CustomImage::create();
        $upl = new Upload();
        $upl->loadIntoFile($data['Image'], $newImage, "/Uploads");
        if ($newImage->ID != 0){
            echo json_encode(['status'=>200, 'msg'=>'Upload Success', 'ID'=>$newImage->ID, 'FileName'=>"Upload Success", 'URL'=>$newImage->URL]);
            return;
        }else{
            echo json_encode(['status'=>500, 'msg'=>'Upload Failed']);
            return;
        }
    }


    public function deleteimage(){
        if (!isset($_GET['id'])){
            echo json_encode(['status'=>500, 'msg'=>'Error Data Not found']);
            return;
        }

        $image = CustomImage::get()->byID($_GET['id']);
        if ($image){
            $image->delete();
            echo json_encode(['status'=>200, 'msg'=>'Delete Success']);
            return;
        }else{
            echo json_encode(['status'=>500, 'msg'=>'Error Data Not found']);
            return;
        }
    }
}