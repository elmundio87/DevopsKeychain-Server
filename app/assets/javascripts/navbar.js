function setActive(item){
	$("nav li").removeClass("active")
	$('nav li:contains(' + item + ')').addClass('active');
}