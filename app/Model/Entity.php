<?php
class Entity extends AppModel {
	public $name = 'Entity';

	// entities types
	public static $ent_types = array('private','corporate','bank');
	// entities attributes (SELECT DISTINCT type FROM transactions;)
	public $ent_attributes = array('addr-street','addr-country');

	public $hasMany = array(
		'Tr_actor' => array(
			'className' => 'Transaction',
			'foreignKey' => 'actor_id',
			'order' => 'Tr_actor.date DESC',
			'dependent' => false),
		'Tr_entity' => array(
			'className' => 'Transaction',
			'foreignKey' => 'entity_id',
			'order' => 'Tr_entity.date DESC',
			'dependent' => false),
		'Log' => array(
			'className' => 'Log',
			'foreignKey' => 'entity_id',
			'order' => 'Log.created')
	);
			
	public $validate = array (
		'name' => array ('rule' => 'notEmpty','message'=>'I need a name'),
		'type' => array (
			'rule-1' => array(
				'rule' => array('chkEntTypes'),
				'message' => "select something from "
				)				
			)
	);

	public function chkEntTypes($check) {
		$my_val = array_values($check);
		return in_array($my_val[0], self::$ent_types);
	}
}
