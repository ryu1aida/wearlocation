// 投稿ボタンが押されたら

$(".post").on("click", function() {
  // 処理
   $(this).css('background-color','rgb(0, 0, 0)');
    $('#new').fadeIn(500);
});
