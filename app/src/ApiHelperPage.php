<?php
use SilverStripe\ORM\DataObject;
use SilverStripe\ORM\DB;
use SilverStripe\Control\HTTPRequest;
use SilverStripe\Control\HTTPResponse;
use SilverStripe\Control\HTTPResponse_Exception;

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
}