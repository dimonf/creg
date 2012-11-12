<?php
class Event extends AppModel {
	public $name = 'Event';
	public $hasMany = array(
		'Transaction' => array(
			'className' => 'Transaction',
			'foreignKey' => 'entity_id',
			'order' => 'Transaction.date DESC',
			'dependent' => true
		),
	);
}

