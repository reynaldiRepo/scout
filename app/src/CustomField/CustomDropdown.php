<?php 

use SilverStripe\Forms\DropdownField;

class CustomDropdown extends DropdownField{
    private $isRequired = false;


    public function __construct(string $name, $title = null, $source = array(), mixed $value = null){
        parent::__construct($name, $title, $source, $value);
        $this->addExtraClass("dropdown has-chosen");
        
    }

    public function validate($validator)
    {
        if ($this->isRequired){
            if (empty($this->value)) {
                $validator->validationError(
                    $this->name, $this->title." Tidak Boleh Kosong", "required"
                );
                return false;
            }
        }
        return true;
    }

    public function setIsRequired($bool){
        $this->isRequired = $bool;
    }
}