var App = {
	
	playerThrow:'?',
	computerTurnURL:'/throw/',
	symbols:{
		rock:'✺',
		paper:'❏',
		scissors:'✄',
	},
	
	init: function() {
		this.clear();
		return false;
	},
	
	clear: function() {
		$('p#move-choosen').html('').hide();
		$('div#right').html('?');
		$('div#left').html('?');
		return false;
	},
	
	play: function(playerThrow) {
		this.playerThrow = playerThrow;
		this.uiPreComputerTurn();
		this.computerTurn();
		return false;
	},
	
	uiPreComputerTurn :function(func) {
		$('div#right').html(this.symbols[this.playerThrow]);
		$('p#move-choosen').html(this.playerThrow); 
		$('p#move-choosen').css('text-transform','capitalize').show();
		return false;
	},
	
	uiPosComputerTurn :function(data) {
		$('div#left').html(this.symbols[data.computerThrow]);
		$('div#notification').removeClass().addClass(data.status);
		$('div#notification').html("❝ " + data.text +  " ❞");
		return false;
	},
	
	computerTurn: function (){
		var that = this;
		$.get(this.bulidURL(),function(data){
			that.uiPosComputerTurn(data);
			return false;
		});
	},
	
	bulidURL: function(){
		return this.computerTurnURL + this.playerThrow;
	}
}

$(function() {
	App.init();
	
	$('div#move a').bind('click', function(){
		App.play($(this).data('move'));
		return false;
	});
});