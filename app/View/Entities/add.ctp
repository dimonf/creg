<!-- File: /app/View/Entities/add.ctp -->

<h1>Add Post</h1>
<?php
echo $this->Form->create('Entity');
echo $this->Form->input('name');
echo $this->Form->input('type',array('raws' => '1'));
echo $this->Form->end('Save entity');
?>
