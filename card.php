<?php
	header('Content-type: text/html; charset=utf-8');
	include "auth.php";
	error_reporting(E_ALL);

	/*
	Скрипт карточки товара
	*/
	include "database.php";
	include "func.php";
	include "scripts.php";
	$con=connect();
	$table='products';
?>
<html>
<head>
	<meta charset="utf-8">
	<title><?php echo $title;?></title>
	<link rel="stylesheet" type="text/css" href="style.css">
<script>
	function btn_reset_click() {
		$('input').val('');	};
</script>

<script>

	// вернуть сумму и количество единиц в корзине пользователя
	function get_cart_info() {
		$.ajax({
			url: 'ajax/ajax_get_cart_info.php',
			type: 'POST',
			async: true,
			dataType: "JSON",
			data: {
				user_id: '<?php echo $_SESSION['id']; ?>'
			},
			beforeSend: function() {
			},
			complete: function() {
			},
			success: function(response)	{
				$('#cart_info').html('Корзина ('+response.amount+')');
			},
			error: function(objAJAXRequest, strError) {
				alert('Произошла ошибка! Тип ошибки: ' +strError);
			}
		});
	};

	// сразу после загрузки страницы выполнить
	$(function() {
		get_cart_info();
	});

	// добавлям товар в корзину пользователю
	function to_cart(id) {
		var user_id='<?php echo $_SESSION["id"];?>';
		$.ajax({
			url: 'ajax/ajax_add_to_cart.php',
			type: 'POST',
			async: true,
			data: {
				id: id,
				user_id: user_id
			},
			beforeSend: function() {
			},
			complete: function() {
			},
			success: function(response)	{
				if (response=='ok') {
					get_cart_info();
					alert('Добавлено в корзину!');
				}
				else alert(response);
			},
			error: function(objAJAXRequest, strError) {
				alert('Произошла ошибка! Тип ошибки: ' +strError);
			}
		});

	};

</script>

<style>
	input{
		width:100%;
	}
</style>

</head>

<body>
<table id="main_table">
	<!-- баннер -->
	<tr>
		<td colspan=2 style="text-align:center">
			<?php
				include('top.php');
			?>
		</td>
	</tr>

	<tr>
		<!-- меню -->
		<td width="280px" class="menu2">
			<?php
				include('menu.php');
			?>
		</td>

		<!-- контент -->
		<td width="900px" class="content">

<?php
	$product_id=empty($_GET['product_id']) ? 0 : abs(intval($_GET['product_id']));
	$query="
		SELECT
			`$table`.`id`,
			`$table`.`name`,
			`$table`.`descr`,
			`categories`.`name` AS `category`,
			`$table`.`price`,
			`discounts`.`value` AS `discount_value`,
			TIMESTAMPDIFF(DAY, `$table`.`date_add`, NOW()) AS `delta`
		FROM
			`$table`
		LEFT JOIN
			`categories` ON `categories`.`id`=`$table`.`cat_id`
		LEFT JOIN
			`discounts` ON `discounts`.`id`=`$table`.`discount_id` AND NOW() BETWEEN `discounts`.`start` AND `discounts`.`stop`
		WHERE 1
			AND products.id=$product_id
	";
	$res=mysqli_query($con, $query) or die(mysqli_error($con));

	$row=mysqli_fetch_array($res, MYSQLI_ASSOC);

	$fname='upload/'.$row['id'].'.jpg';
	if (!file_exists($fname)) { // если нет файла, показать "НЕТ ФОТО"
		$fname='upload/0.jpg';
	};

	if ($row['delta']<30) { // товар добавлен меньше 30 дней назад, т.е. это новинка
		$new="<div><img src='images/new.png' style='width:100px'></div>";
	}
	else {
		$new='';
	};

	if ($row['discount_value']) { // цена со скидкой
		$price_new=number_format (round($row['price']*(1-$row['discount_value']/100), 2), 2, '.', '');
		$price_str="
			<font style='color: #888; font-size:x-small; text-decoration:line-through'>$row[price]$valuta</font>
			<img src='images/discount.png' height='24px' title='Скидка'>
			<font style='color: #000;'>$price_new$valuta</font>
		";
		$price_str=trim($price_str);
	}
	else {
		$price_str="<font style='color: #000;'>$row[price]$valuta</font>";
	};

	echo "
		<h1>$row[name]</h1>
		$new
		<p>$row[descr]</p>
		<img src=\"$fname\" width=\"500px\" height=\"500px\" style='cursor:pointer;' onclick='to_cart($row[id]);'><br>
		<p>Цена: $price_str</p>
		<button onclick='to_cart($row[id]);'>В корзину</button>
	";

?>

		</td>
	</tr>

	<!-- подвал -->
	<tr>
		<td colspan=2>
			<?php
				include('footer.php');
			?>
		</td>
	</tr>

</table>

</body>
</html>