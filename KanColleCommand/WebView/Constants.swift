import Foundation

struct Constants {

    static let START_EVENT = Notification.Name.init("GameStart")

    static let HOME_PAGE = "http://www.dmm.com/netgame/social/-/gadgets/=/app_id=854854/"

    static let FULL_SCREEN_SCRIPT = "javascript:(($,_)=>{const html=$.documentElement,gf=$.getElementById('game_frame'),gs=gf.style,gw=gf.offsetWidth,gh=gw*.6;let vp=$.querySelector('meta[name=viewport]'),t=0;vp||(vp=$.createElement('meta'),vp.name='viewport',$.querySelector('head').appendChild(vp));html.style.overflow='hidden';$.body.style.cssText='min-width:0;overflow:hidden;margin:0';$.querySelector('.dmm-ntgnavi').style.display='none';$.querySelector('.area-naviapp').style.display='none';$.getElementById('ntg-recommend').style.display='none';gs.position='fixed';gs.marginRight='auto';gs.marginLeft='auto';gs.top='-16px';gs.right='0';gs.zIndex='100';gs.transformOrigin='50% 16px';if(!_.kancolleFit){const k=()=>{const w=html.clientWidth,h=_.innerHeight;w/h<1/.6?gs.transform='scale('+w/gw+')':gs.transform='scale('+h/gh+')';w<gw?gs.left='-'+(gw-w)/2+'px':gs.left='0'};_.addEventListener('resize',()=>{clearTimeout(t);t=setTimeout(k,10)});_.kancolleFit=k}kancolleFit()})(document,window)"

    static let TAG: String = "Handled"

}