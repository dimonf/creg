<!-- File: /app/View/Entities/index.ctp -->
<h1>Entities list</h1>
<?php echo $this->Html->Link('Add entity',array('controller'=>'entities',
	'action' => 'add' )); ?>
<table>
	<tr>
		<th>Id</th>
		<th>Name</th>
		<th>edit</th>
		<th>delete</th>
		<th>Type</th>
		
	<tr>
	<?php foreach ($entities as $ent): ?>
	<tr>
		<td><?php echo $ent['Entity']['id']; ?></td>
		<td><?php echo $this->Html->link($ent['Entity']['name'],
			array('controller'=>'entities', 
					'action'=>'view',
					$ent['Entity']['id'])); ?></td>
		<td><?php echo $this->Html->link('edit',
			array('controller'=>'entities',
				'action'=>'edit',
				$ent['Entity']['id'])); ?></td>
		<td><?php echo $this->Form->postLink('delete',
			array('controller'=>'entities',
				'action'=>'delete',
				$ent['Entity']['id']),
			array('confirm' => 'Are you sure?')); ?></td>
		<td><?php echo $ent['Entity']['type']; ?></td>
	</tr>
	<?php endforeach; ?>
	<?php unset($ent) ?>
</table>
			
		
