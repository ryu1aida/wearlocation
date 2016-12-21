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

// ＃タグ機能の実装でぶっこんだやつ
//= require jquery
//= require jquery_ujs
//= require tag-it
//= require_tree .

$( document ).ready(function(){
  var i, len, ref, results, tag;
  $('#post-tags').tagit({
    fieldName: 'post[tag_list]',
    singleField: true,
    availableTags: gon.available_tags
  });

  if (gon.post_tags != null) {
    ref = gon.post_tags;
    results = [];
    for (i = 0, len = ref.length; i < len; i++) {
      tag = ref[i];
      results.push($('#post-tags').tagit('createTag', tag));
    }
    return results;
  }
})
// このjavascriptにより、#article-tagsのついたviewの要素がarticle[tag_list]の名前でpostされるようになります。また、既にタグ付けされている記事についてはgonにより予め入力フォームに表示されるようになります。




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
