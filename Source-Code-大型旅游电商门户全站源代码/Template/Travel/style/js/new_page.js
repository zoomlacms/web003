$(function(){
/*
---------------------首页beg---------------------
*/

	/*大图展开*/
	var ntIndexMainH = $(".ntIndexMain").height();
	$(".overlay-close").css("top",ntIndexMainH);
	$('.indexItem li').click(function(){
			$(".tipsbs").css("opacity","0").css("display","none");
			var target=this,
				overlayTarget="."+$(target).attr('id')+"-overlay",
				l=$(target).position().left,
				screenW=$('.ntIndexMain').width(),
				originW=$(target).width(),
				index=$(overlayTarget).index(),
				count=$('.indexOverlay>div').length,
				overlay_wrapH=null;
			$(target).animate({opacity:0},100,function(){
				$(overlayTarget).css({opacity:"1",display:"block",width:originW,left:l});
				overlay_wrapH=$(overlayTarget).find(".content-overlay_wrap").height();
				$(overlayTarget).css({opacity:"1",display:"block",width:originW,left:l});
			
				
				$(overlayTarget).attr({id:'cur',indexCount:index+'-'+count}).find(".content-overlay_wrap").css("top",ntIndexMainH);
				$(".overlay-close").css("top",(ntIndexMainH-overlay_wrapH)/2);
				
				setTimeout(function(){
					$(overlayTarget).css({width:originW,left:l})
					.animate({
						left:0,
						width:screenW
					},300,function(){
						$(target).css({"opacity":""});
						$(overlayTarget).children().children(".content-overlay_wrap").animate({top:(ntIndexMainH-overlay_wrapH)/2},300,function(){$(".IndexBt").css("display","block").animate({opacity:"1"},300)});
						$(this).find(".overlay-close").css({"display":"block"});
						$(".indexItem").css("display","none");
					});	
					$(".indexOverlay").css("z-index","50");
					
				},300);	
			});
			
		});
		$('.indexOverlay .overlay-close').click(function(){
			$(".IndexBt").animate({opacity:"0"},300,function(){
				$(this).css("display","none");
				$(".tipsbs").css("display","block").css("opacity","1");
			});
			$("#overlay").css("width","");
			$(".indexOverlay").css("z-index","50");
			$(".indexItem").css("display","block");
			$(this).css({"display":""});
			var overlayTarget=$(this).closest('div').attr('class'),
				overlayClass="."+overlayTarget,
				liTarget="#"+overlayTarget.replace('-overlay','');
				l=$(liTarget).position().left,
				originW=$(liTarget).width();
			    $(overlayClass).find(".content-overlay_wrap").animate({top:ntIndexMainH},300,function(){
				$(overlayClass).animate({
				left:l,
				width:originW
				},300,function(){
					setTimeout(function(){
						$(overlayClass).css({width:"",left:"",display:""}).attr({id:null,indexCount:null});
						$(".indexOverlay").animate({"opacity":0},100,function(){
							$(this).css({"z-index":"","opacity":""});
							
						});
						
					},300);
					
				});
				
			});
			
		});
		//左右翻转
		$('.IndexNext').click(function(){
			item_index01= 0;
			var indexcount=$("#cur").attr("indexcount").split('-'),
				index=parseInt(indexcount[0]),
				count=parseInt(indexcount[1]),
				curW=$("#cur").width(),
				top=$("#cur").find(".content-overlay_wrap").position().top;
				
			if(index==(count-1)) {
				index=-1; 
			};
			$("#cur").css({"z-index":100}).animate({left:-curW},300,function(){
				$(this).attr({"id":null,"indexcount":null}).css({"display":"",width:"",opacity:"",left:"","z-index":""}).find("content-overlay_wrap").css({"top":""});
			});
			var target=$('.indexOverlay>div:eq('+(index+1)+')');
			target.css({display:"block",width:curW,opacity:1}).attr({"id":"cur",indexcount:index+1+'-'+count}).find(".content-overlay_wrap").css({"top":top});
			target.find(".overlay-close").css({display:"block"});
		});
		$('.IndexPre').click(function(){
			item_index01= 0;
			var indexcount=$("#cur").attr("indexcount").split('-'),
				index=parseInt(indexcount[0]),
				count=parseInt(indexcount[1]),
				curW=$("#cur").width(),
				top=$("#cur").find(".content-overlay_wrap").position().top,
				target=$('.indexOverlay>div:eq('+(index-1)+')');
			if(index==0){
				index=count;
			}
			$("#cur").css({"z-index":100}).animate({left:curW},300,function(){
				$(this).attr({"id":null,"indexcount":null}).css({"display":"",width:"",opacity:"",left:"","z-index":""}).find("content-overlay_wrap").css({"top":""});
			});
			target.css({display:"block",width:curW,opacity:1}).attr({"id":"cur",indexcount:index-1+'-'+count}).find(".content-overlay_wrap").css({"top":top});
			target.find(".overlay-close").css({display:"block"});
		});
		/*最新推荐左右滚动显示*/
		var item_index01= 0;
		$(".mos_list").on("click",".overlay_wrap_right .zxtj span.right",function(){
			console.log(2);
			var item_list01 = $(this).siblings(".content").children("div");
			var item_list_item01 = item_list01.find("a");
			var item_width01 = item_list_item01.width();
			var item_size01 = item_list_item01.length;
			$(this).css({"cursor":"pointer","background-position":"-56px -80px"}).siblings("span.left").css({"cursor":"pointer","background-position":"-32px -80px"});
			item_list01.stop().animate({left:"-"+item_width01 * (item_index01+1) + "px"});
			item_index01++;
			if(item_index01 >= item_size01-1){
				item_list01.stop().animate({left:"-"+item_width01 * (item_size01-1) + "px"});
				item_index01=item_size01-1;
				$(this).css({"cursor":"auto","background-position":"-56px -56px"}).siblings("span.left").css({"cursor":"pointer","background-position":"-32px -80px"});
				
			}
		});
		$(".mos_list").on("click",".overlay_wrap_right .zxtj span.left",function(){
			console.log(1);
			var item_list01 = $(this).siblings(".content").children("div");
			var item_list_item01 = item_list01.find("a");
			var item_width01 = item_list_item01.width();
			var item_size01 = item_list_item01.length;
			$(this).css({"cursor":"pointer","background-position":"-32px -80px"}).siblings("span.right").css({"cursor":"pointer","background-position":"-56px -80px"});
			item_list01.stop().animate({left:"-"+item_width01 * (item_index01-1) + "px"});
			item_index01--;
			if(item_index01 <= 0){
				item_list01.stop().animate({left:"0"});
				item_index01=0;
				$(this).css({"cursor":"auto","background-position":"-32px -56px"}).siblings("span.right").css({"cursor":"pointer","background-position":"-56px -80px"});
			}
		});
/*
---------------------首页end---------------------
*/	

});


//首页 6.11
$(function(){
	$(".big_pic,.close_bt,.mos_tc").hide();
	$(".prev").mouseover(function(){
		$(this).stop().animate({left:"65px"})
		}).mouseout(function(){
			$(this).stop().animate({left:"65px"});
			})
	$(".next").mouseover(function(){
		$(this).stop().animate({right:"65px"})
		}).mouseout(function(){
			$(this).stop().animate({right:"65px"})
			})
	$( '.mos_list ul' ).on(  'click', '.close_bt', function(){
		$(this).parent("li").animate({width:"430px"},200);
		$(".big_pic,.close_bt,.mos_tc").hide();
		$(".sm_pic").show();
	});
	$(".prev,.next").click(function(){
		$(".mos_list li").animate({width:"430px"},200).find(".big_pic,.close_bt,.mos_tc").hide().siblings(".sm_pic").show();
		})
	
	//滚动
	 var lilength = $(".mos_list ul li").length;
	 var liwidth = 480;
	 var ulwidth = lilength * liwidth;
	 $('.mos_list ul').css('width',ulwidth + 'px');
	 
	  $('.prev').click(function(){
		var obj_li = $(".mos_list ul li:last").clone();
		obj_li.prependTo($(".mos_list ul"));
		$(".mos_list ul li:last").remove();
		$(".mos_list ul").css('left',-liwidth);
		$('.mos_list ul').stop().animate({left:-150},function(){
		});
	  });
	  $('.next').click(function(){
		$('.mos_list ul').stop(true,true).animate({left:-liwidth},function(){
			var obj_li = $(".mos_list ul li").eq(0).clone();
			$(this).css('left',-150);
			obj_li.appendTo($(".mos_list ul"));
			$(".mos_list ul li").eq(0).remove();
		});
	  });
	 
	//让图片始终在第二个位置出来
	$( '.mos_list ul' ).on(  'click', '.sm_pic', function(){
		var ele = this;
		
		var par_li = $( this ).closest( 'li' );
		var par_ul = $( this ).closest( 'ul' );
		var last_index = par_li.siblings('li').length;
		
		var li_index = par_li.index();
		banner_animate_hide( ele );
		banner_animate_show( ele );
		
//		if( li_index == 0 )
//		{
//			//第一个li
//			var obj_li = $(".mos_list ul li:last").clone();
//			obj_li.prependTo($(".mos_list ul"));
//			$(".mos_list ul li:last").remove();
//			par_ul.css('left',-liwidth);
//			par_ul.stop().animate({left:-150},function(){
//				//banner_animate( ele );
//				banner_animate_show( ele );
//			});
//		//第二个li
//		}
//		else if( li_index == 1 )
//		{
//			banner_animate_show( ele );
//		}
//		 else if( li_index > 1 ) {
//	
//			var get_li_index = li_index - 1;
//			var animate_width = -430*get_li_index - 150;
//			
//			$('.mos_list ul').stop(true,true).animate({left:animate_width},function(){
//				var obj_li = $(".mos_list ul li:lt("+get_li_index+")").clone();
//				$(this).css('left',-150);
//				obj_li.appendTo($(".mos_list ul"));
//				$(".mos_list ul li:lt("+get_li_index+")").remove();
//				banner_animate_show( ele );
//		    });
//			
//		}
		
	});
	
	//先滚动再展开
	var banner_animate_show =function( ele )
	{
		$(ele).parent("li").animate({width:"660px"});
		$(ele).hide().parent("li").find(".big_pic,.close_bt,.mos_tc").show();
		
	}
	
	var banner_animate_hide = function( ele )
	{
		var ele_par = $(ele).parent("li").siblings("li");
		ele_par.find(".big_pic,.close_bt,.mos_tc").hide();
		ele_par.animate({width:"430px"});
		ele_par.find( '.sm_pic' ).show();
		//ele_par.animate({width:"330px"},2000).find(".big_pic,.close_bt,.mos_tc").hide( 1500 ).siblings(".sm_pic").show( 1500 );
	}
	
	
	$( '.mos_list ul' ).on(  'click', '.sm_pic', function(){
		$(this).removeClass("sm_pic_current");
		})
	$( '.mos_list ul' ).on(  'click', '.sm_pic', function(){
		$(this).addClass("sm_pic_current");
		})
	$( '.mos_list ul' ).on(  'click', '.mos_tc', function(){
		$(this).parent("li").animate({width:"430px"},200);
		$(".big_pic,.close_bt,.mos_tc").hide();
		$(".sm_pic").show();
		})	
})