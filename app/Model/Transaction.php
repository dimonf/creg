<?php
class Transaction extends AppModel {
	public $name = 'Transaction';
	public $belongsTo = array(
		'Event' => array(
			'className' => 'Event',
			'foreignKey' => 'event_id'),
		'Actor' => array(
			'className' => 'Entity',
			'foreignKey' => 'actor_id'),
		'Entity' => array(
			'className' => 'Entity',
			'foreignKey' => 'entity_id')
	);
	public $hasMany = array(
		'Log' => array(
			'className' => 'Log',
			'foreignKey' => 'transaction_id',
			'order' => 'Log.created DESC',
			'dependent' => false)
	);
}
