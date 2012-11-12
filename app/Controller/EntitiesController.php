<?php
class EntitiesController extends AppController {
	public $helper = array('Html', 'Form','Session');
	public $components = array('Session');

	public function index() {
		$this->set('title_for_layout','list of my Entities');
		//$this->layout='my';
		$this->set('entities', $this->Entity->find('all'));
	}
	public function view($id = null) {
		$this->Entity->id = $id;
		$this->set('entity',$this->Entity->read());
		//debug($this->Entity->read());
	}
	
	public function add() {
		if ($this->request->is('post')) {
			$this->Entity->create();
			if ($this->Entity->save($this->request->data)) {
				debug($this->request->data, True);
				$this->Session->setFlash('New entity has been saved.');
				$this->redirect(array('action'=>'index'));
			} else {
				$this->Session->setFlash('Unable to save new record');
			}
		}
	}

	public function delete($id) {
		if ($this->request->is('get')) {
			throw new MethodNotAllowedException();
		}
		if ($this->Entity->delete($id)) {
			$this->Session->setFlash('Record '.$id .' has been deleted');
			$this->redirect(array('action' => 'index'));
		}
	}
	
	public function edit($id = null) {
		$this->Entity->id=$id;
		if ($this->request->is('get')){
			$this->request->data = $this->Entity->read();
		} else {
			if ($this->Entity->save($this->request->data)){
				$this->Session->setFlash('This entity has been updated');
				$this->redirect(array('action'=>'index'));
			} else {
				$this->Session->setFlash('Unable to update record');
			}	
		}
	}
	
	public function test() {
		return 'got it: test';
	}

}
