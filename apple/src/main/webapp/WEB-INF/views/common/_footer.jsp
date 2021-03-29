<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="author" content="Your Name">
<meta name="description" content="Example description">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="icon" type="image/x-icon" href="" />
<link rel="stylesheet" type="text/css"
	href="<c:url value="/resources/css/bootstrap.min.css"/>">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<script src="https://kit.fontawesome.com/a076d05399.js"></script>
<link rel="stylesheet" href="<c:url value="/resources/css/mainpage.css"/>">
 <link href="https://developers.google.com/maps/documentation/javascript/examples/default.css" rel="stylesheet">
<script
	src="https://maps.googleapis.com/maps/api/js?v=3.exp&sensor=false&libraries=places"></script>
<style>
input {
	border: 1px solid rgba(0, 0, 0, 0.5);
}

input.notfound {
	border: 2px solid rgba(255, 0, 0, 0.4);
}
</style>
<script>
	function initialize() {
		var mapOptions = {
			center : new google.maps.LatLng(37.4346, 126.7968),
			zoom : 10,
			mapTypeId : google.maps.MapTypeId.ROADMAP
		};
		var map = new google.maps.Map(document.getElementById('map-canvas'),
				mapOptions);

		var input = /** @type {HTMLInputElement} */
		(document.getElementById('address'));
		var autocomplete = new google.maps.places.Autocomplete(input);

		autocomplete.bindTo('bounds', map);

		var infowindow = new google.maps.InfoWindow();
		var marker = new google.maps.Marker({
			map : map
		});

		google.maps.event
				.addListener(
						autocomplete,
						'place_changed',
						function() {
							infowindow.close();
							marker.setVisible(false);
							input.className = '';
							var place = autocomplete.getPlace();

							if (!place.geometry) {
								// Inform the user that the place was not found and return.
								input.className = 'notfound';
								return;
							}

							// If the place has a geometry, then present it on a map.
							if (place.geometry.viewport) {
								map.fitBounds(place.geometry.viewport);
							} else {
								map.setCenter(place.geometry.location);
								map.setZoom(17); // Why 17? Because it looks good.
							}

							marker.setIcon(/** @type {google.maps.Icon} */
							({
								url : place.icon,
								size : new google.maps.Size(71, 71),
								origin : new google.maps.Point(0, 0),
								anchor : new google.maps.Point(17, 34),
								scaledSize : new google.maps.Size(35, 35)
							}));

							//위치 등록 부분
							marker.setPosition(place.geometry.location);
							var pot = place.geometry.location;
							var x = pot.lat().toFixed(4);
							var y = pot.lng().toFixed(4);

							alert("x = " + x + " y = " + y);

							marker.setVisible(true);

							var address = '';
							if (place.address_components) {
								address = [
										(place.address_components[2]
												&& place.address_components[2].short_name || ''),
										(place.address_components[1]
												&& place.address_components[1].short_name || ''),
										(place.address_components[0]
												&& place.address_components[0].short_name || '') ]
										.join(' ');
							}

							infowindow.setContent('<div><strong>' + place.name
									+ '</strong><br>' + address);
							infowindow.open(map, marker);
						});
		autocomplete.setTypes([]); // 전체 주소
	}

	google.maps.event.addDomListener(window, 'load', initialize);
</script>

</head>
<body>
	<footer>
		<div class="main-content">
			<div class="left box">
				<h2>About us</h2>
				<div class="content">
					<p style="font-size: 12px;">
						안녕하세요 저희는 미래능력 개발교원에서 수업을 배우고 있는 2조
						애플 스토어 팀입니다. <br>
						팀장으로 임동호, 팀원으로는 김정부, 구슬기,
						김지호, 채원우, 이규원으로 총 5명으로 구성되어있습니다. <br>
						<br>
						각자 맡은 파트로는 아래 내용입니다.<br>
						팀장 임동호: 상품파트<br>
						팀원 김지호: 로그인, 회원가입 및 마이페이지<br>
						팀원 김정부: 게시판<br>
						팀원 구슬기: 관리자(게시판,회원)<br>
						팀원 이규원: 관리자(상품,주문)<br>
						팀원 채원우: 장바구니, 결제<br>
						<br>
						부족한 실력이지만 약 5주동안 열심히 준비했습니다.<br>
						감사합니다.
					</p>
				</div>
			</div>
			<div class="center box">
				<h2>Address</h2>
				<div class="content">
					<div class="place">
						<input id="address" type="text" size="50">
						<div id="map-canvas" style="width: 600px; height: 300px;"></div>
					</div>
					<div class="phon">
						<span class="fas fa-phone-alt"></span> <span class="text">Tel:02-441-6006
							/ Fax:02-428-9694</span>
					</div>
					<div class="email">
						<span class="fas fa-mpa-envelope"></span> <span class="text">abcd@google.com</span>
					</div>
				</div>
			</div>
			<div class="right box">
				<h2>Contact us</h2>
				<form action="#">
					<div class="email">
						<div class="text">Email *</div>
						<input type="email" required>
					</div>
					<br>
					<div class="msg">
						<div class="text">Message *</div>
						<textarea rows="2" cols="25" required></textarea>
					</div>
					<br>
					<div class="btn">
						<button type="submit">Send</button>
					</div>
				</form>
			</div>
		</div>
	</footer>
</body>
</html>