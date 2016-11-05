// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require underscore
//= require gmaps/google
//= require_tree .

// キャンパスの要素を取得する
var canvas = document.getElementById( 'map-canvas' ) ;

// 中心の位置座標を指定する
var latlng = new google.maps.LatLng( 35.792621 , 139.806513 );

// 地図のオプションを設定する
var mapOptions = {
	zoom: 15 ,				// ズーム値
	center: latlng ,		// 中心座標 [latlng]
};

// [canvas]に、[mapOptions]の内容の、地図のインスタンス([map])を作成する
var map = new google.maps.Map( canvas , mapOptions ) ;





// キャンパスの要素を取得する
var canvas = document.getElementById( 'map-canvas' ) ;

// 中心の位置座標を指定する
var latlng = new google.maps.LatLng( 35.792621 , 139.806513 );

// 地図のオプションを設定する
var mapOptions = {
	zoom: 15 ,				// ズーム値
	center: latlng ,		// 中心座標 [latlng]
};

// [canvas]に、[mapOptions]の内容の、地図のインスタンス([map])を作成する
var map = new google.maps.Map( canvas , mapOptions ) ;

// マーカーのインスタンスは配列で管理しよう
var markers = [] ;

// マーカーのインスタンスを作成する
markers[0] = new google.maps.Marker({
	map: map ,
	position: new google.maps.LatLng( 35.792621 , 139.806513 ) ,
}) ;
