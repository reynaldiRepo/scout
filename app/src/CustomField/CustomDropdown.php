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
        if ($isRequired){
            if (empty($this->value)) {
                $validator->validationError(
                    $this->name, 'Is Required Field', false
                );
            }
        }
        return true;
    }

    public function setIsRequired(boolval $bool){
        $this->isRequired = $bool;
    }
}