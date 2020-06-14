// JavaScript Document
/*-------------函数------------*/
/*左侧导航固定定位*/
	 function navselectlShow(){
		$(window).scroll(function(){
			if($(window).scrollTop()>84){
				$(".left_nav,.left_nav_us").css({top:"45px"});
				if(navigator.appVersion.indexOf('MSIE 6.0')>0){
					$(".left_nav").css({top:$(window).scrollTop()+45})
				}
			}else{
				$(".left_nav,.left_nav_us").css("top",129-$(window).scrollTop());
				if(navigator.appVersion.indexOf('MSIE 6.0')>0){
					$(".left_nav").css("top","129px");
				}
			}
		}).trigger("scroll");
	};
	$(function(){
		$(".modelMain .left_nav dd.cur").siblings("dt").addClass("cur");
		/*设置默认下左侧导航收起状态*/
		$(".modelMain .left_nav dt.cur").siblings().css("display","block");
		/*设置左侧导航收起隐藏状态*/
		$(".modelMain .left_nav dl dd").siblings(".cur").show(300);
		$(".modelMain .left_nav dl dt").click(function(){
			$(".modelMain .left_nav dl dt").removeClass("cur");
			$(this).addClass("cur");
			$(this).siblings().show(300);
			$(this).parent("dl").siblings().children("dd").hide(300);
		});
		/*获取右侧导航纵坐标值*/
		var ddchildH = $(".modelMain .left_nav dd.child ul").height();
		/*右侧导航有子栏目*/
		$(".modelMain .left_nav dd.child").hover(function(){
			$(this).children("ul").show(500);
		},function(){
			$(this).children("ul").css("display","none");
		});
		/*素材库首页*/
		$(".modelMain .materialWrapIndex ul li a").hover(function(){
			$(this).children().children("p").stop(true,true).slideDown();
			//$(this).children("span").stop(true,true).slideDown();
			$(this).siblings("span").stop(true,true).animate({
				width:"203px",
				height:"203px",
				top:"0px",
				opacity:1
			},300);
			$(this).children("div").stop(true,true).animate({
				top:"55px"
			},300);
		},function(){
			$(this).children().children("p").stop(true,true).slideUp();
			$(this).siblings("span").stop(true,true).animate({
				width:"0px",
				height:"0px",
				top:"50%",
				opacity:0
			},1000);
			$(this).children("div").stop(true,true).animate({
				top:"75px"
			},300);
		});
	});
	/*回到顶部*/
	function scollTopShow(){
		$(window).scroll(function(){
			if($(window).scrollTop()>200){
				$(".scollTopBt").css("display","block");
				$(".scollTopBt").css({bottom:"100px"});
				if(navigator.appVersion.indexOf('MSIE 6.0')>0){
					$(".scollTopBt").css({bottom:$(window).scrollTop()+$(window).height()-100})
				}
			}else{
				$(".scollTopBt").css("display","none");
				if(navigator.appVersion.indexOf('MSIE 6.0')>0){
					$(".scollTopBt").css("bottom","100px");
				}
			}
		}).trigger("scroll");
	};
	scollTopShow();
	/*滚动条滚动，顶部导航固定*/
	function navFixedShow(){
		$(window).scroll(function(){
			if($(window).scrollTop()>84){
				$(".newTrendHeader .nav").addClass("navFixed");
				if(navigator.appVersion.indexOf('MSIE 6.0')>0){
					$(".newTrendHeader .navFixed").css({top:$(window).scrollTop()})
				}
			}else{
				$(".newTrendHeader .nav").removeClass("navFixed");
				if(navigator.appVersion.indexOf('MSIE 6.0')>0){
					$(".newTrendHeader .nav").removeClass("navFixed");
				}
			}
		}).trigger("scroll");
	};
	navFixedShow();
	//个人中心左侧导航
	function qushi_sideShow(){
		$(window).scroll(function(){
			if($(window).scrollTop()>84){
				$(".qushi_side").css({top:"45px"});
				if(navigator.appVersion.indexOf('MSIE 6.0')>0){
					$(".qushi_side").css({top:$(window).scrollTop()+45})
				}
			}else{
				$(".qushi_side").css("top",175-$(window).scrollTop());
				if(navigator.appVersion.indexOf('MSIE 6.0')>0){
					$(".qushi_side").css("top","175px");
				}
			}
		}).trigger("scroll");
	};
	/*不同分辨率元素宽度设置*/
	$(function(){
		if(screenWidth<=1024){
			$(".newTrendHeader").addClass("s1024");
			$(".left_nav").addClass("left_navs1024");
		}else if(screenWidth<1920){
			$(".newTrendHeader").removeClass("s1024,s1920");
		}else{
			$(".newTrendHeader").addClass("s1920");
		}
	});
	
/*弹出层*/
$(function(){
	/*首页改版提示*/
	$(".openIndex").click(function(){
		$(".openIndex").css("display","none");
		$(".indexTipsbg_left,.indexTips_left").animate({left:"-1000px",opacity:0},1200,function(){
			$(".indexTipsbg_left,.indexTips_left").css("display","none");
		});
		$(".indexTipsbg_right,.indexTips_right").animate({left:"1408px",opacity:0},1200,function(){
			$(".indexTipsbg_right,.indexTips_right").css("display","none");
		});
	});
	/*回到顶部*/
	$(".scollTopBt").click(function(){
		$("body,html").animate({scrollTop:0},1);
	});
	/***游客点击书籍弹出层***/
	$(".book_tab_cont a").click(function(){
		showpopbox($(".book_unreg_popbox"));	
	})
	//向前向后
	$(".reg_popbox a.prev").click(function(){
		var reg_is = $(this).closest(".reg_popbox").find(".msg_cont").is(":visible");										
		var img_index = $(".pop_img_list li:visible").index();
		var img_size = $(".pop_img_list li").size();
		img_index--;
		if(img_index < 0)  //等于0时原位
		{
			img_index = img_index+1;
			
		}
		if(reg_is)
		{
			img_index = 2;  //出现注册框点击时的情况
			$(this).closest(".reg_popbox").find(".msg_cont").hide();
			$(this).closest(".reg_popbox").find(".pop_img_cont").show();
			$(".reg_popbox a.next").show();
			}
		$(".pop_img_list li").eq(img_index).removeClass("none").siblings().addClass("none");
	})
	$(".reg_popbox a.next").click(function(){
		var img_index = $(".pop_img_list li:visible").index();
		var img_size = $(".pop_img_list li").size();
		img_index++;
		if(img_index > img_size-1)  //达到最后一张图片时状态
				{
					img_index = 0;
				}
		if(img_index>2){   //大于三张图片时出现注册框
			
			$(this).closest(".reg_popbox").find(".pop_img_cont").hide();
			$(this).closest(".reg_popbox").find(".msg_cont").show();
			$(".reg_popbox a.prev").show();
			$(".reg_popbox a.next").hide();
			
		}
		 $(".pop_img_list li").eq(img_index).removeClass("none").siblings().addClass("none");	
	})
	//鼠标经过reg_popbox显示隐藏向前向后按钮
	$(".reg_popbox").hover(function(){
		var msg_is = $(this).find(".msg_cont").is(":visible");
		if(msg_is)
		{
			var login_is = $(this).find(".login_form").is(":visible");
			var reg_success_is = $(this).find(".reg_success").is(":visible");
			if(login_is)
			{
				$(".reg_popbox a.prev,.reg_popbox a.next").hide();	
				}else{
					$(".reg_popbox a.next").hide();
					$(".reg_popbox a.prev").show();
				}
		}
		else{
				$(".reg_popbox a.prev,.reg_popbox a.next").show();	
			}
	},function(){
		$(".reg_popbox a.prev,.reg_popbox a.next").hide();	
		});
   //关闭弹出层
	$(".close,.cancle").click(function(){	
		$(".popbox").hide();
		$(".mask").hide();
	})
	function showpopbox(obj){
		$(".mask").css("opacity","0.5").show();	
		if($.browser.msie&&$.browser.version==6){
		   $(".mask").append("<iframe style='width:100%;height:100%;filter:Alpha(opacity=0);' border='0' frameborder='0'></iframe>").css({height:$("html").height(),width:$("html").width()});
		}
		var popbox_w = obj.outerWidth();	
		var popbox_h = obj.outerHeight();
		obj.css({"margin-left":-0.5*popbox_w+'px',"margin-top":-0.5*popbox_h+'px'});
		obj.show();
	}
});
$(function(){
/*
---------------------首页beg---------------------
*/
	/*首页7张大图全屏评价分块显示*/
	$(".newTrendMain,.newTrendMain ul li,.newTrendMain ul li div,.newTrendMain .ntIndexMain li.Women h5").css("height",$(window).height()-$(".newTrendHeader").height()-30);/*设置首页7张大图内容高度*/
	$(".newTrendMain li,.newTrendMain .ntIndexMain li.Women h5").css("width","14.2%");
	var liWidth = $(".newTrendMain li").width();
	$(".newTrendMain li p a").css("opacity","0.3");

	$(".ntIndexMain li.link .cur").css("opacity","0.6"); //这是句奇葩的话，加上会导致ie8-不透明，不舍得删，留作纪念
	$(".ntIndexMain li.Activity .cur").css("width",$(".ntIndexMain li.Activity").width());
	$(".newTrendMain .indexItem li").hover(function(){
		/**/$(".newTrendMain li").find(".link").addClass("cur");
		$(this).find(".link").removeClass("cur");
		$(this).stop(true,true).animate({width:"+=9.8%"},350).siblings().stop(true,true).animate({width:"-=1.6%"},350);

		$(this).find("a").stop(true,true).animate({width:"120px","opacity":1},350);
		$(this).find("p").stop(true,true).animate({top:"40%"},200);
	},function(){
		/**/$(".newTrendMain li").stop(true,true).animate({width:"14.2%"},350);
		$(".newTrendMain li").find("a").stop(true,true).animate({width:"0","opacity":0.3},350);
		$(".newTrendMain li").find(".link").addClass("cur");
		$(".newTrendMain li").stop(true,true).find("p").animate({top:"50%"},200);
	});
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
/*
---------------------二级内页公共结构样式beg---------------------
*/
	$(".modelMain").css("min-height","610px").css("padding-bottom","30px");/*二级内页设置最小高度，防止右侧内容极少出现底部信息位置在浏览器窗口中部*/
	//$(window).height()-$(".newTrendHeader").height()-30
	//$(".left_nav").css("height",$(window).height());/*设置左侧导航高度*/
	
/*
---------------------二级内页公共结构样式end---------------------
*/
	/*文章详情页里的图片控制宽度*/
	var pImgW = $(".modelMain .Cont_article .modelMain_content p").width();
	$(".modelMain .Cont_article .modelMain_content p img").css("max-width",pImgW);
	/*女装市场分析，男装市场分析热点视频解读hover效果*/
	$(".model_video .img a").hover(function(){
		$(this).children("span").stop().animate({top:"20px"},400)
	},function(){
		$(".model_video .img a").children("span").stop().animate({top:"-40px"},400)
	});
	/*素材库*/
	$(".modelMain .select_nav .type div").hover(function(){
		$(this).addClass("select");
	},function(){
		$(this).removeClass("select");
	})
	//文章正文回到顶部						   
	/**/$(window).scroll(function(){
		if ($(window).scrollTop()>1620){
			$(".gotop").css({"opacity":0.6,"display":"block"}).fadeIn();
		}else{
			$(".gotop").fadeOut();
		}
	});
	$(".gotop").click(function(){
		$("body,html").animate({scrollTop:0},500);
		return false;
	});
	$(".gotop").hover(function(){
		$(this).animate({opacity:0.8})						   
				},function(){
		$(this).animate({opacity:0.6})			
	})
	//IE6
//	if($.browser.version <= 6){
//		fiexd_top_right("gotop",400);
//		function fiexd_top_right(obj_class,top_px){
//			var cnam = "." + obj_class;
//			var top = top_px;
//			$(window).scroll(function(){
//				$(cnam).css("top",(top + $(window).scrollTop())+"px");
//			});
//		}
//	};
	/*解读详情页*/
	$(".interpretationXq .video_view").css("height",$(".interpretationXq").height());
	$(".interpretationXq .MainWrap .content").css("top",($(".interpretationXq .video_view").height()-$(".video_box").height()-37)/2);
	/***关于我们***/
	$(".about_us_nav li").click(function(){
		var index = $(this).index();								 
		$(this).addClass("cur").siblings().removeClass("cur");	
		$(this).closest(".us_tab_box").find(".us_tab_cont").eq(index).removeClass("none").siblings(".us_tab_cont").addClass("none");
	});
	/***联系我们***/
	$(".cont_item").first().find("dd").show();
	$(".cont_item").first().find("i").addClass("cur");
	$(".cont_item dt").click(function(){
		//$(this).closest(".cont_item").find("dd").slideToggle();
		$(this).find("dd").css("display","block");
		//$(this).closest(".cont_item").find("i").toggleClass("cur");	
	});
	/*分享更多*/
	function sharMore(){
		var bds_moreTop = $(".bds_more").offset().top;
		var Cont_articleTop = $(".modelMain .Cont_article .modelMain_content").offset().top;
		var bds_moreLeft = $(".bds_more").offset().left;
		var bdshare_mHeight = $("#bdshare_m").height();
		$("#bdshare_m").css("top",bds_moreTop-bdshare_mHeight-Cont_articleTop).css("left",bds_moreLeft-22);
		$("#bds_more").hover(function(){
			$("#bdshare_m").css("display","block");
		},function(){
			$("#bdshare_m").css("display","none");
		});
	}
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
	 
	  $('.next').click(function(){
		var obj_li = $(".mos_list ul li:last").clone();
		obj_li.prependTo($(".mos_list ul"));
		$(".mos_list ul li:last").remove();
		$(".mos_list ul").css('left',-liwidth);
		$('.mos_list ul').stop().animate({left:-150},function(){
		});
	  });
	  $('.prev').click(function(){
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
		if( li_index == 0 )
		{
			//第一个li
			var obj_li = $(".mos_list ul li:last").clone();
			obj_li.prependTo($(".mos_list ul"));
			$(".mos_list ul li:last").remove();
			par_ul.css('left',-liwidth);
			par_ul.stop().animate({left:-150},function(){
				//banner_animate( ele );
				banner_animate_show( ele );
			});
		//第二个li
		}else if( li_index == 1 ){
			banner_animate_show( ele );
		}
		 else if( li_index > 1 ) {
	
			var get_li_index = li_index - 1;
			var animate_width = -430*get_li_index - 150;
			
			$('.mos_list ul').stop(true,true).animate({left:animate_width},function(){
				var obj_li = $(".mos_list ul li:lt("+get_li_index+")").clone();
				$(this).css('left',-150);
				obj_li.appendTo($(".mos_list ul"));
				$(".mos_list ul li:lt("+get_li_index+")").remove();
				banner_animate_show( ele );
		    });
			
		}
		
	});
	
	//先滚动再展开
	var banner_animate_show =function( ele )
	{
		$(ele).parent("li").animate({width:"660px"});
		$(ele).hide().siblings(".big_pic,.close_bt,.mos_tc").show();
		
	}
	
	var banner_animate_hide = function( ele )
	{
		var ele_par = $(ele).parent("li").siblings("li");
		ele_par.find(".big_pic,.close_bt,.mos_tc").hide();
		ele_par.animate({width:"430px"});
		ele_par.find( '.sm_pic' ).show();
		//ele_par.animate({width:"330px"},2000).find(".big_pic,.close_bt,.mos_tc").hide( 1500 ).siblings(".sm_pic").show( 1500 );
	}
	
	
	$( '.mos_list ul' ).on(  'mouseover', '.sm_pic', function(){
		$(this).removeClass("sm_pic_current");
		})
	$( '.mos_list ul' ).on(  'mouseleave', '.sm_pic', function(){
		$(this).addClass("sm_pic_current");
		})
	
})

//素材库供应商
$(document).ready(function(){
	$(".sel_text").click(function(e){
	e.stopPropagation();
	$(".sel_xl").toggleClass("sel_block");
	$(".sel_text").toggleClass("sel_xj");
	});
	$(document).click(function(){
	if($(".sel_xl").hasClass("sel_block")){
	$(".sel_xl").removeClass("sel_block");
	}
	});
	$(document).click(function(){
	if($(".sel_text").hasClass("sel_xj")){
	$(".sel_text").removeClass("sel_xj");
	}
	});
});

$(function(){
	$(".sel_xl ul li").click(function(){
		$aa=$(this).text();
		$(".sel_text").text($aa);
		})
	})


//首页广告位
$(function(){
	$(".po_gg").animate({"height":"770px"},1500);
	$(document).on('click','.po_gg span',function(e){
		$(".po_gg").animate({"height":"0"},1500);
	})
})

//$(function(){
//	document.oncontextmenu=new Function("event.returnValue=false;");
//	document.onselectstart=new Function("event.returnValue=false;");
//	})

//一级品牌hover
$(function(){
	$(".first_brand_type").hover(function(){
		$(this).addClass("cur");
		$(this).find(".second_brand_type_wrapper").removeClass("none");
		},function(){
			$(this).removeClass("cur");
		    $(this).find(".second_brand_type_wrapper").addClass("none");
    });
	/***    二级品牌hover    ***/
	$(".second_brand_type li").hover(function(){
		$(this).addClass("cur");
		
		},function(){
			$(this).removeClass("cur");
    })
})



//云素材input事件
$(document).ready(function(){
	$(".second_brand_type_wrapper input").click(function(e){
	e.stopPropagation();
	$(this).addClass("ourcolor");
	});
	$(document).click(function(){
	if($(".second_brand_type_wrapper input").hasClass("ourcolor")){
	$(".second_brand_type_wrapper input").removeClass("ourcolor");
	}
	});
});
$(document).ready(function(){
	$(".close").click(function(){
        $(".theme-popover-in,.theme-popover-mask").hide();
    }); 
    $(".qiangxian").click(function(){
        $(".theme-popover-in,.theme-popover-mask").hide();
    });
    /*
	var odermeetingStyle = function(){
		var leftW = (getFullSize().w-1110)/2+545;
			$('div.theme-popover-in').css({
				'left': leftW+'px'
			});
	}();*/

});
function getFullSize(){
	var w = Math.max(document.documentElement.clientWidth,document.body.clientWidth) + Math.max(document.documentElement.scrollLeft, document.body.scrollLeft);
	var h = Math.max(document.documentElement.clientHeight,document.body.clientHeight) +  Math.max(document.documentElement.scrollTop, document.body.scrollTop);
	w = Math.max(document.documentElement.scrollWidth,w);
	h = Math.max(document.documentElement.scrollHeight,h);
	return {w:w,h:h};
}












