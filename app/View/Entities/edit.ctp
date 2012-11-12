<!-- File: /app/View/Posts/edit.ctp -->

<h1>Edit Post </h1>
<?php
		  echo $this->Form->create('Entity',array('action' => 'edit'));
		  echo $this->Form->input('id', array('type' => 'hidden'));
		  echo $this->Form->input('name');
		  echo $this->Form->input('type');
		  echo $this->Form->end('Save entity');

