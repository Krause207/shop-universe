<?php
	/*
	Главная страница
	*/
	header('Content-type: text/html; charset=utf-8');
	error_reporting(E_ALL);
	include('auth.php');
	include('func.php');
	$title='Главная';
?>
<html>
<head>
	<meta charset="utf-8">
	<title><?php echo $title;?></title>
	<link rel="stylesheet" type="text/css" href="style.css">
</head>

<body>
<table id="main_table" border="0">
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
		<td width="270px" class="menu" style="vertical-align:top;">
			<?php
				include('menu.php');
				include('showcase.php');
			?>
		</td>

		<!-- контент -->
		<td width="900px"   style="vertical-align:top;">

			<h1>Контакты</h1>


						<p>Адрес: Москва, ул. Ленинская, 56-71
						</p>

						<p>
Единый телефон: 8-800-123-45-67,
(7816) 15-69-74
</p>
<p>
      Консультирование новых и существующих клиентов, техническая поддержка
без выходных 8.00 - 23.00
						</p>
						<p>
						Часы работы: Прием заказов на сайте круглосуточно
						</p>
						<p>
              Для обращений клиентов физических лиц:<a class="contacts-emails__link" href="computershop.ru">computershop.ru</a>
						</p>
						<p>
              Для информационных запросов:<a class="contacts-emails__link" href="info@computershop.ru">office@computershop.ru</a>
						</p>



            </div>

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