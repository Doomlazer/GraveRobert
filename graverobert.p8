pico-8 cartridge // http://www.pico-8.com
version 18
__lua__
--grave robert
--by jerkstore

--version 1.4 final

function _init()
t,offset=0,0
//screenshake offset
music(0)
txtx,txty,txto,tc =0,129,10,6
daughterhead=false

credits={}

dwindraw,pwin,ftime=false,false,0

dhdraw,dockdraw,abbysaved=false,false,false

electric,electrictimerstart=false,5
electrictiimerstop,alivetimer=200,40
rampage=false

ringsold=false

wifeghost=false
wifeghosttimer=30
daughterghost=false
daughterghosttimer=30
//daughtershead=false

wifedissed=false
daughterdissed=false

dugupgraves=0
foundtreasure=false

txtcount=0

blood=0
button=0

difficulty="easy"
dcol1,dcol2,dcol3=11,5,5

//gx,gy=40,40
//gdir=0
//gcount=0

ghosts={}
gnum=0
gdif=50


dhunger=0.8
dhealth=1
ddraw=false
dhd=rnd(0.3)
dhungerd=0.05
dalive=true
dsick=true


drawallbars=false
sdraw=false
maxghost=0

pfood=2
pmed=0
hmdraw=false
mdraw=false

ptickets=0
dticket=0
ticketcost=750

gmode="intro"
px=8*8
py=8*8
followx=px
followy=py
pinv={}
pdigging=false
pdigcount=0
pspr=1
bprsd=20

phealth=1
pmoney=15

pitems={}
items={"head","torso","right leg","right arm","left leg","left arm"}
jitems={}

fitems={}
fdraw=false

txt1="welcome to grave robert! use"
txt2="arrow keys to move. press 'z'"
txt3="to dig up grave! 'x' for info."

row={}

gdock={}
dock={
 {49,49,159,49,49,24,24,24,148,148,157,142,142,142,142,142},
 {49,128,48,48,128,24,34,24,143,158,156,142,142,142,142,142},
 {49,48,48,48,48,48,48,143,143,143,156,142,142,142,142,142},
 {49,50,48,48,128,128,143,143,143,143,156,142,142,142,142,142}, 
 {49,48,48,128,128,128,128,143,143,143,156,142,142,142,142,142},
 {49,48,48,48,48,128,128,128,143,143,156,142,142,142,142,142},
 {49,50,48,48,48,48,48,128,143,147,155,142,142,149,150,142},
 {49,48,50,48,48,48,48,48,48,147,147,146,146,151,152,142},
 {49,128,48,48,48,128,128,128,143,145,145,142,142,153,154,142},
 {49,128,128,50,128,22,128,128,143,143,156,142,142,142,142,142},
 {49,49,49,49,49,49,49,148,148,148,157,142,142,142,142,142}
}

gtown={}
town={
 {49,49,49,49,49,49,49,49,62,49,49,49,49,49,49,49},
 {49,52,52,48,48,33,33,33,126,48,48,48,48,48,48,49},
 {49,50,50,48,48,32,32,32,48,48,48,48,48,48,48,49},
 {49,33,33,33,48,32,34,32,126,48,48,48,52,48,48,49}, 
 {49,32,32,32,48,54,126,48,126,48,48,53,129,54,48,49},
 {49,32,34,32,48,48,48,48,126,48,48,33,33,33,48,49},
 {49,48,127,127,48,127,127,127,48,48,48,32,32,32,48,49},
 {49,48,48,48,48,48,48,48,126,48,48,32,61,32,48,49},
 {49,48,53,48,48,48,48,48,48,127,48,127,127,48,48,49},
 {49,48,48,48,48,54,48,48,48,48,48,48,48,48,48,49},
 {49,49,49,49,49,49,49,49,49,49,49,49,49,49,49,49}
}

gcastle={}
castle={
 {49,49,49,49,24,49,24,49,24,49,24,49,49,49,49,49},
 {49,22,128,128,24,24,24,24,24,24,24,128,128,128,23,49},
 {49,128,128,128,24,25,25,24,25,25,24,128,128,128,128,49},
 {49,23,128,128,24,25,25,24,25,25,24,128,128,128,128,49}, 
 {49,128,128,128,24,24,24,31,24,24,24,128,128,128,128,49},
 {49,128,128,128,128,128,128,48,128,128,128,128,22,128,128,49},
 {49,128,128,128,128,128,48,48,48,48,128,128,128,128,128,49},
 {49,128,128,128,50,48,48,48,48,48,48,48,48,128,128,49},
 {49,128,128,128,128,128,50,48,48,48,48,48,48,48,128,49},
 {49,128,23,128,128,128,128,128,48,48,48,128,128,48,48,14},
 {49,49,49,49,49,49,49,49,49,49,49,49,49,49,49,49}
}
ggraveyard={}
graveyard={
 {49,49,49,49,49,49,49,49,47,49,49,49,49,49,49,49},
 {49,48,48,52,48,52,48,52,126,48,52,48,52,48,52,49},
 {49,54,48,50,48,50,48,50,126,48,50,48,50,48,50,49},
 {49,48,48,127,127,127,127,127,127,127,127,127,127,127,127,49}, 
 {49,52,48,52,48,52,48,52,126,48,52,48,52,48,48,49},
 {49,50,48,50,48,51,48,50,126,48,50,48,50,48,48,49},
 {49,127,127,127,127,127,127,127,127,127,127,127,127,48,48,49},
 {49,48,48,48,54,52,48,52,126,48,52,48,52,48,48,49},
 {49,53,48,48,48,50,48,50,126,48,50,48,50,48,54,49},
 {49,48,48,48,48,127,127,127,127,127,127,127,127,48,48,49},
 {49,49,49,49,49,49,49,49,63,49,49,49,49,49,49,49}
}

gchurch={}
church={
 {49,49,49,49,49,49,49,49,49,49,49,49,49,49,49,49},
 {49,128,128,128,128,128,128,128,18,128,128,128,128,128,128,49},
 {49,22,23,22,23,22,128,19,20,21,128,128,128,128,128,49},
 {49,23,52,52,52,23,19,38,38,38,21,128,23,22,23,49}, 
 {49,22,50,50,50,22,35,39,38,39,37,128,22,52,22,49},
 {49,23,22,48,22,23,35,39,38,39,37,128,23,50,23,49},
 {49,128,128,48,128,128,35,39,38,39,37,128,128,48,128,49},
 {49,128,128,48,128,128,35,39,161,39,37,128,22,48,22,49},
 {49,128,128,48,128,128,128,128,48,128,128,128,128,48,128,49},
 {15,48,48,48,48,48,48,48,48,48,48,48,48,48,48,44},
 {49,49,49,49,49,49,49,49,46,49,49,49,49,49,49,49}
}

gshop={}
shop={
 {49,49,49,49,49,49,49,49,49,49,49,49,49,49,49,49},
 {49,48,48,50,48,48,48,48,50,48,50,50,48,48,50,49},
 {49,48,48,48,48,50,48,48,48,48,48,50,48,50,48,49},
 {49,53,48,33,33,33,33,33,48,50,48,48,50,48,50,49}, 
 {49,48,48,41,41,41,41,41,50,33,33,33,33,48,50,49},
 {49,48,48,41,42,41,43,41,48,41,30,43,41,48,48,49},
 {49,48,48,48,48,48,48,48,48,48,126,48,48,48,48,49},
 {49,48,54,48,126,48,48,48,48,48,48,48,48,48,48,49},
 {49,48,48,48,126,48,48,48,48,48,126,53,48,40,48,49},
 {45,127,127,48,127,127,127,48,127,127,127,127,127,48,50,49},
 {49,49,144,49,49,49,49,49,49,49,49,49,49,49,49,49}
}


ghome={}
home={
 {55,55,55,55,55,55,55,55,55,55,55,55,55,55,55,55},
 {55,55,55,55,55,55,55,55,55,55,55,55,55,55,55,55},
 {55,55,55,55,55,55,55,55,55,55,55,55,55,55,55,55},
 {55,55,55,55,57,57,57,57,57,57,57,55,55,55,55,55}, 
 {55,55,55,55,57,56,56,56,56,56,57,55,55,55,55,55},
 {55,55,55,55,57,58,56,56,56,59,57,55,55,55,55,55},
 {55,55,55,55,57,56,56,56,56,56,57,55,55,55,55,55},
 {55,55,55,55,57,57,57,60,57,57,57,55,55,55,55,55},
 {55,55,55,55,55,55,55,55,55,55,55,55,55,55,55,55},
 {55,55,55,55,55,55,55,55,55,55,55,55,55,55,55,55},
 {55,55,55,55,55,55,55,55,55,55,55,55,55,55,55,55}
}

gsell={}
sell={
 {55,55,55,55,55,55,55,55,55,55,55,55,55,55,55,55},
 {55,55,55,55,55,55,55,55,55,55,55,55,55,55,55,55},
 {55,55,55,55,55,55,55,55,55,55,55,55,55,55,55,55},
 {55,55,55,55,41,41,41,41,41,41,41,55,55,55,55,55}, 
 {55,55,55,55,41,56,56,56,56,56,41,55,55,55,55,55},
 {55,55,55,55,41,56,56,56,04,56,41,55,55,55,55,55},
 {55,55,55,55,41,56,56,56,56,56,41,55,55,55,55,55},
 {55,55,55,55,41,28,41,41,41,41,41,55,55,55,55,55},
 {55,55,55,55,55,55,55,55,55,55,55,55,55,55,55,55},
 {55,55,55,55,55,55,55,55,55,55,55,55,55,55,55,55},
 {55,55,55,55,55,55,55,55,55,55,55,55,55,55,55,55}
}

gbuy={}
buy={
 {55,55,55,55,55,55,55,55,55,55,55,55,55,55,55,55},
 {55,55,55,55,55,55,55,55,55,55,55,55,55,55,55,55},
 {55,55,55,55,55,55,55,55,55,55,55,55,55,55,55,55},
 {55,55,55,55,41,41,41,41,41,41,55,55,55,55,55,55}, 
 {55,55,55,55,41,56,56,06,56,41,55,55,55,55,55,55},
 {55,55,55,55,41,56,56,56,05,41,55,55,55,55,55,55},
 {55,55,55,55,41,56,56,07,56,41,55,55,55,55,55,55},
 {55,55,55,55,41,29,41,41,41,41,55,55,55,55,55,55},
 {55,55,55,55,55,55,55,55,55,55,55,55,55,55,55,55},
 {55,55,55,55,55,55,55,55,55,55,55,55,55,55,55,55},
 {55,55,55,55,55,55,55,55,55,55,55,55,55,55,55,55}
}

glab={}
lab={
 {55,55,55,55,55,55,55,55,55,55,55,55,55,55,55,55},
 {55,55,55,55,55,55,55,55,55,55,55,55,55,55,55,55},
 {55,55,55,55,55,55,55,55,55,55,55,55,55,55,55,55},
 {55,55,55,55,24,24,24,24,24,24,24,55,55,55,55,55}, 
 {55,55,55,55,24,12,11,27,10,10,24,55,55,55,55,55},
 {55,55,55,55,24,26,26,26,10,10,24,55,55,55,55,55},
 {55,55,55,55,24,26,26,26,10,10,24,55,55,55,55,55},
 {55,55,55,55,24,24,13,24,24,24,24,55,55,55,55,55},
 {55,55,55,55,55,55,55,55,55,55,55,55,55,55,55,55},
 {55,55,55,55,55,55,55,55,55,55,55,55,55,55,55,55},
 {55,55,55,55,55,55,55,55,55,55,55,55,55,55,55,55}
}


end

function _update()
 t+=1
 if (gmode=="intro") then 
  update_intro()
 elseif (gmode=="stage1") then
  update_stage1()
 elseif (gmode=="dead") then 
  update_dead()
 elseif (gmode=="txt") then 
  update_txt()
 elseif (gmode=="win") then
  update_win()
 end
 
end

function _draw()
 if (gmode=="intro") then
  draw_intro()
 elseif (gmode=="stage1") then
  draw_stage1()
 elseif (gmode=="dead") then
 	draw_dead()
 elseif (gmode=="txt") then
  draw_txt()
 elseif (gmode=="win") then
  draw_win()
 end
end

function get_ptile()
  local a=py/8+1
  local t=row[a]
  local b=px/8+1
  
  return t[b]
end

function get_gtile(g)
  local a=g.y/8+1
  local t=row[a]
  local b=g.x/8+1
  
  return t[b]
end

function set_ptile(n)
  local a=py/8+1
  local t=row[a]
  local b=px/8+1
  t[b]=n
end


function draw_bottom()
 rect(0,8*11,127,114,7)
 //31 charaters of text per line max
 print(txt1,2.5,8*11+3,6)
 print(txt2,2.5,8*12+3,6)
 print(txt3,2.5,8*13+3,6)
 
 //health bar
 rectfill(0,8*14.5,60*phealth,8*15.5,8)
 rect(0,8*14.5,60,8*15.5,7)
 print("bob's health",2.5,8*14.75,11)
 
 //carry bar
 rectfill(65,8*14.5,65+10*(#jitems),8*15.5,8)
 rect(65,8*14.5,127,8*15.5,7)
 print("encumbrence",67.5,8*14.75,11)
 
end


function screen_shake()
  local fade = 0.75
  local offset_x=16-rnd(32)
  local offset_y=16-rnd(32)
  offset_x*=offset
  offset_y*=offset
  
  camera(offset_x,offset_y)
  offset*=fade
  if offset<0.05 then
    offset=0
  end
end
-->8
//stages

function update_stage1()
 cpx=px
 cpy=py
 bprsd+=1
 
 if wifeghost then
  wifeghosttimer-=1
  if (wifeghosttimer==1) then
   wifeghost=false
   wifedissed=true
   add(ghosts,create_ghost(13,4,132))
 
  end
 end
 
 if daughterghost then
  daughterghosttimer-=1
  if (daughterghosttimer==1) then
   daughterghost=false
   daughterdissed=true
   add(ghosts,create_ghost(14,4,133))
  end
 end
 
 local gp=get_ptile()
 //standing on wife's grave
 if (gp==129) and not pdigging then 
  txt1="this is the grave of your"
  txt2="beloved wife. she passed away"
  txt3="five years ago from cholera."
 end
 
 //daughters grave
  if (gp==131) and not pdigging then 
  txt1="the grave of your daughter. she"
  txt2="was the only person you had"
  txt3="left in your life."
 end
 
 //standing on ticket sales
 if (gp==155) then
  dockdraw=true
  if (ptickets+dticket<2) then
   if (t%40==0) then
    if (pmoney>ticketcost) then
     ptickets+=1
     txt1="you purchase a ticket to"
     txt2="america for $"..ticketcost.."."
     txt3=""
     pmoney-=ticketcost
     sfx(9)
    else
     txt1="tickets to the new world are"
     txt2="$"..ticketcost.." each."
     txt3=""
    end
   end
  end
   
 
 else
  dockdraw=false
 end
 
  //burried treasure
 if (gp==158) and not pdigging then 
  txt1="there seems to be something"
  txt2="burried beneath the sand."
  txt3=""
 else
  if ( txt1=="there seems to be something") then
   txt1,txt2="",""
  end
 end
 
 if btn(5) then
  drawallbars=true
 else
  drawallbars=false
 end
 
 if (bprsd>8) then 
 
  if btn(0) or btn(1) or btn(2) or btn(3) then
   set_follow()
  end
  
  if btn(0) then
   if (dticket==1) then cleanandfollow() end
   px-=8
   pmoved=true
   pdigging=false
   bprsd=0
  end
  if btn(1) then
   if (dticket==1) then cleanandfollow() end
   px+=8
   pmoved=true
   pdigging=false
   bprsd=0
  end  
  if btn(3) then
   if (dticket==1) then cleanandfollow() end
   py+=8
   pmoved=true
   pdigging=false
   bprsd=0
  end
  if btn(2) then
   if (dticket==1) then cleanandfollow() end  
   py-=8
   pmoved=true
   pdigging=false
   bprsd=0
  end
  //dig
  if btn(4) then
   local p=get_ptile()
   if (p==158) or (p==50) or (p==129) or (p==131) then
    if (#jitems >=6) then
     txt1="you're over encombered. sell"
     txt2="something before robbing"
     txt3="another grave."
     sfx(0)
    else
     if not pdigging then
      pdigging=true
      pdigcount=0
      bprsd=0
     end
    end
   else
    sfx(1)
    bprsd=0
   end
  end

  //for digging animation
  if pdigging then
   if (gp==129) then
    txt1="digging..."
    txt2="up your dead wife's grave."
    txt3="times are desparate!"
   elseif (get_ptile()==131) then
    txt1="you begin to weep as you"
    txt2="exhume you daughter's freshly"
    txt3="burried corpse."
   else
    txt1="digging..."
    txt2=""
    txt3=""
   end
   if (bprsd%10==0) then
    if (pspr==3) then
     pspr=2
     sfx(8)
     pdigcount+=1
    else 
     pspr=3
     sfx(8)
     pdigcount+=1
    end
   end
   
   if (pdigcount > 8) then
    pdigging=false
    rand_grave()
   end
  else
   pspr=1
  end

  //prevent moving to grass, etc.	
  local c=get_ptile()
  
  if (c==153) or (c==154) or (c==149) or (c==150) or (c==152) or (c==161) or (c==157) or (c==148) or (c==142) or (c==24) or (c==10) or (c==41) or(c==21) or (c==20) or (c==19) or (c==37) or (c==35) or (c==57) or (c==32) or (c==34) or (c==52) or (c==49) or (c==43) or (c==39) then
   px,py=cpx,cpy
   
   if not (c==51) then
    sfx(1)
   end 
  end  
  
 end
 
 //switch locations
 //from town to graveyard
 if (gp==62) then
  py=8*9
  set_follow()
  town=row
  row=graveyard
  gtown=ghosts
  ghosts=ggraveyard
  set_max_ghost()
  txt1="this is the town graveyard. it"
  txt2="sure filled up after the"
  txt3="plague."
 end
 
 //from graveyard to town
 if (gp==63) then
  py=8*1
  set_follow()
  graveyard=row
  row=town
  ggraveyard=ghosts
  ghosts=gtown
  set_max_ghost()
  txt1="a collection of ramshackle huts"
  txt2="makes up the poor part of town."
  txt3="this is where you live."
 end

 //from town to home
 if (gp==61) then
  px,py=8*7,8*6
  set_follow()

  town=row
  row=home
  gtown=ghosts
  ghosts=ghome
  set_max_ghost()
  if (dalive) then
   txt1="your modest abode. things just"
   txt2="aren't the same since your"
   txt3="wife passed last year."
  else   
   txt1="doesn't feel like much of a"
   txt2="home anymore."
   txt3=""
  end
 end
 
 //from home to town
 if (gp==60) then
  px,py=8*12,8*8
  set_follow()
  home=row
  row=town
  ghome=ghosts
  ghosts=gtown
  set_max_ghost()
  txt1="back to work, i guess..."
  txt2=""
  txt3=""
 end
 
 //frome graveyard to church
 if (gp==47) then
  py=8*9
  set_follow()
  graveyard=row
  row=church
  ggraveyard=ghosts
  ghosts=gchurch
  set_max_ghost()
  txt1="it a beautiful church."
  txt2=""
  txt3=""
 end

 //from shop to church
 if (gp==45) then
  px=8*14
  set_follow()
  shop=row
  row=church
  gshop=ghosts
  ghosts=gchurch
  set_max_ghost()
  txt1="it a beautiful church."
  txt2=""
  txt3=""
 end
 
 //from castle to church
 if (gp==14) then
  px=8*1
  set_follow()
  castle=row
  row=church
  gcastle=ghosts
  ghosts=gchurch
  set_max_ghost()
  txt1="it a beautiful church."
  txt2=""
  txt3=""
 end
 
 //from church to shop
 if (gp==44) then
  px=8*1
  set_follow()
  church=row
  row=shop
  gchurch=ghosts
  ghosts=gshop
  set_max_ghost()
  txt1="this is the trading district."
  txt2="the many different odors"
  txt3="attack you at once"
 end
  
 //from shop to dock
 if (get_ptile()==144) then
  py=8*1
  set_follow()
  shop=row
  row=dock
  gshop=ghosts
  ghosts=gdock
  set_max_ghost()
  txt1="the town docks. here you can"
  txt2="purchase tickets to america."
  txt3=""
 end
 
 if (get_ptile()==159) then
  py=8*9
  set_follow()
  dock=row
  row=shop
  gdock=ghosts
  ghosts=gshop
  set_max_ghost()
  txt1="you suddenly miss the fresh"
  txt2="ocean breeze."
  txt3=""
 end
 
 //from church to castle
 if (get_ptile()==15) then
  px=8*14
  set_follow()
  church=row
  row=castle
  gchurch=ghosts
  ghosts=gcastle
  set_max_ghost()
  txt1="an ominous castle rises before"
  txt2="you. it's the home of the mad"
  txt3="doctor frank."
 end
 
 
 
  //from church to grave
 if (get_ptile()==46) then
  py=8*1
  set_follow()
  church=row
  row=graveyard
  gchurch=ghosts
  ghosts=ggraveyard
  set_max_ghost()
  txt1="the town graveyard. you spend"
  txt2="much more time here than"
  txt3="you would like to."
 end
 
 //from castle to lab
 if (get_ptile()==31) then
  px,py=8*6,8*6
  set_follow()
  castle=row
  row=lab
  gcastle=ghosts
  ghosts=glab
  set_max_ghost()
  txt1="the doctor's science lab."
  txt2="though it's objectivly little"
  txt3="more than a butcher shop."
 end 
 
 //from lab to castle
 if (get_ptile()==13) then
  px,py=8*7,8*5
  set_follow()
  lab=row
  row=castle
  glab=ghosts
  ghosts=gcastle
  set_max_ghost()
  txt1="you are always glad to leave"
  txt2="the doctor's castle. his"
  txt3="experiments seem dangerous!"
 end 
 
 //from shop to sell
 if (get_ptile()==42) then
  px,py=8*5,8*6
  set_follow()
  shop=row
  row=sell
  gshop=ghosts
  ghosts=gsell
  set_max_ghost()
  txt1="this ghoul buys all the things"
  txt2="you steal from the dead."
  txt3=""
 end
 
 //from shop to buy
 if (get_ptile()==30) then
  px,py=8*5,8*6
  set_follow()
  shop=row
  row=buy
  gshop=ghosts
  ghosts=gbuy
  set_max_ghost()
  txt1="here you can buy 'meat' or"
  txt2="snake oil."
  txt3=""
 end
 
 //from sell to shop
 if (get_ptile()==28) then
  px,py=8*4,8*6
  set_follow()
  sell=row
  row=shop
  gsell=ghosts
  ghosts=gshop
  set_max_ghost()
  txt1="nice day for a grave robbing!"
  txt2=""
  txt3=""
 end
 
  //from buy to shop
 if (get_ptile()==29) then
  px,py=8*10,8*6
  set_follow()
  buy=row
  row=shop
  gbuy=ghosts
  ghosts=gshop
  set_max_ghost()
  txt1="snake oil is so expensive."
  txt2=""
  txt3=""
 end
 
 //stand on sister bed
 if (get_ptile()==59) then
  txt1="your daughter has been ill for"
  txt2="weeks now. she needs food and"
  txt3="medicine or will soon die."
  ddraw=true
  //transfer food and med
  if (t%1==0) then
   if (dhunger<1) and (pfood>0) then
    if (dhunger<.2) then
     dhunger+=0.02
     pfood-=0.01   
    else
     if (pfood > 0.4) then
      dhunger+=0.02
      pfood-=0.01
     end
    end
    
    if (pfood<0) then pfood=0 end
   end
   if (dhealth<1) and (pmed>0) then
    dhealth+=0.01
    pmed-=0.01
    if (pmed<0) then pmed=0 end
   end

   //daughter lives or dies if in house
   if (dhealth<=0) then
    dhealth=0
    set_ptile(130)
    px-=16
    sfx(0)
    offset=1
    //add grave
    local a=5 //y
    local q=town[a]
    local b=14 //x
    q[b]=131
    a=4
    local w=town[a]
    w[b]=52
    //remove daughter if out of bed
    local p=5 //y
    local k=home[p]
    local o=8 //x
    k[o]=56
    dticket=0
    txt1="your daughter has succumb to"
    txt2="illness and passed away. you"
    txt3="bury her next to her mother."
    dalive=false
    if (pmoney<0) then pmoney=0 end
   end
   
   if (dhealth>=1) then
    //daughter recovers
    dhealth=1
    set_ptile(8)
    local a=py/8
    local t=row[a]
    local b=px/8
    t[b]=9
    txt1="it's a miracle!! your daughter"
    txt2="is finally feeling better!!"
    txt3="maybe things aren't so bad."
    px-=16
    py-=8
    dsick=false
    sfx(9)
   end
  end
 else
  ddraw=false
  
  //kill daughter if not in home
  if (dhealth<=0) and (dalive) then
   dhealth=0
   //set_ptile(130)
   sfx(0)
   offset=1
   //add grave
   local a=5 //y
   local q=town[a]
   local b=14 //x
   q[b]=131
   a=4
   local w=town[a]
   w[b]=52
   //remove healty daughter if exists
   local p=5 //y
   local k=home[p]
   local o=8 //x
   k[o]=56
   
   //change daughters bed
   local c=6 //y
   local e=home[c]
   local d=10 //x
   e[d]=130

   
   txt1="your daughter has succumb to"
   txt2="illness and passed away."
   txt3=""
   pmoney-=5
   dalive=false 
   dticket=0   
   if (pmoney<0) then pmoney=0 end
  end
  
 end

 
 //daughters bed if dead
 if (get_ptile()==130) then
  txt1="it's you daughter's bed, at"
  txt2="least it was."
  txt3=""
  if (phealth<1) then
   phealth+=0.01
  end
 end
 
 if (get_ptile()==151) then
  if (ptickets>=1) then
   if (dticket>=1) then
    dwindraw=true
    dticket-=1
    txt1="you and abbey board the ship."
    txt2="your dream for a better life"
    txt3="might finally come true."
   else
    pwin=true
    txt1="you set sail for america."
    txt2="regretably, without your"
    txt3="daughter abbey."
   end
   bprsd=-130
   ptickets-=1
   
   sfx(6)
  else
   if dwindraw or pwin then
    //end game
    if (bprsd==-10) then
     ftime=t
     txty=129
     add_credit()
     gmode="win"
    end
   else
    txt1="this boat will take you to the"
    txt2="new world, but each passanger"
    txt3="must have a ticket."
   end
  end
 end
 
 if (get_ptile()==12) then
  phealth+=0.05
  if (phealth>1) then phealth=1 end
  txt1="drinking this slime seems to"
  txt2="invigorate you. it tastes"
  txt3="really disgusting though."
 end
 
 if (get_ptile()==27) then
  phealth-=0.01
  txt1="you shouldn't be drinking"
  txt2="from the blue vat of acid."
  txt3=""
 end

 
 //and over frankenstien parts
 if (get_ptile()==11) then
  fdraw=true
  if (t%40==0) then
   if (#pitems>0) then
    txt1="you sold the mad doctor a "
    txt2=pitems[1]
    local r=flr(rnd(250)+250)
    txt3="gained $"..r
    txt3=""
    add(fitems,pitems[1])
    del(pitems,pitems[1])
    pmoney+=r
    sfx(9)
    if (#fitems==6) then
     electric=true
    end
  // else
   // txt1="after selling your wares you"
   // txt2="now have $"..pmoney
   // txt3=""
   end  
  
  end
 else
  fdraw=false
 end
 
 //heal while in bed
 if (get_ptile()==58) then
  txt1="you lie down for a bit, hoping"
  txt2="to get some much needed rest."
  txt3=""
  if (phealth<1) then
   phealth+=0.01
  end
 end
 
 if (get_ptile()==40) then
  txt1="this is the drinking water for"
  txt2="most of the town's residents."
  txt3=""
  if (phealth<1) then
   phealth+=0.01
  end
 end 
 
 if (get_ptile()==22) or (get_ptile()==22) then
  txt1="now you are trampling flowers?"
  txt2=""
  txt3=""
 end

 
 if (get_ptile()==04) then
  sdraw=true
  if (t%40==0) then
   if (#jitems>0) then
    local x
    if (jitems[1]=="wife's ring") then
     x=200
     ringsold=true
     txt1="regretfully, sell your wife's"
     txt2="cherrished wedding ring for "
     txt3="$"..x.."."
    elseif (jitems[1]=="gold doubloons") then
     if (difficulty=="easy") then
      x=3500
     elseif (difficulty=="normal") then
      x=1000
     else
      x=500
     end
     x+=flr(rnd(100))
     txt1="the ghoul exchanges the gold"
     txt2="doubloons for $"..x.."."
     txt3=""
    else
     x=flr(rnd(20)+1)
     txt1="you sold the "..jitems[1]
     txt2="gained $"..x.."."
     txt3=""
    end

    del(jitems,jitems[1])
    pmoney+=x
    sfx(7)
  // else
    //txt1="nothing to sell."
    //txt2="you have $"..pmoney
    //txt3=""
   end
  end
 else
  sdraw=false
 end 
  
 if (get_ptile()==05) then
  txt1="the shopkeeper will sell"
  txt2="anyone, even you!"
  txt3=""
 end
  
 if (get_ptile()==06) then
  hmdraw=true
  if (t%20==0) then
   if (pmoney>=5) then
    if (pfood<2) then
     txt1="you buy a small amount of"
     txt2="food for $5."
     txt3=""
     pmoney-=5
     pfood+=0.2
     if (pfood>2) then pfood=2 end
     sfx(13)
    else
     txt1="you have all the food you can"
     txt2="carry."
     txt3=""
    end
   else
    txt1="you can't afford any more"
    txt2="food."
    txt3="" 
   end 
  end
 else
  hmdraw=false
 end  
 
 if (get_ptile()==07) then
  mdraw=true
  if (t%20==0) then
   if (pmoney>=50) then
    if (pmed<1) then
     txt1="you buy some of the foul"
     txt2="smelling snake oil for $50."
     txt3=""
     pmoney-=50
     pmed+=0.1
     if (pmed>1) then pmed=1 end
     sfx(14)
    else
     txt1="you have all the snake oil you"
     txt2="can carry."
     txt3=""
    end
   else
    txt1="you can't afford to buy any"
    txt2="snake oil."
    txt3="" 
   end 
  end
 else
  mdraw=false
 end
 
 if (get_ptile()==08) then
  txt1="this is your daughter's bed."
  txt2="rest in your own. it's one of"
  txt3="the few luxuries you have."
 end
 
 //feed healed daughter
 if (get_ptile()==09) then
  dhdraw=true
  if (dticket==1) then
   txt1="abbey is overcome with joy as"
   txt2="you hand her the ticket. she"
   txt3="follows you to the dock."
  else
   txt1="your daughter is the only good"
   txt2="thing in an otherwise dismal"
   txt3="existence."
  end
  if (ptickets==2) then
   dticket+=1
   ptickets-=1
   set_follow()
   sfx(9)
  end
  if (t%1==0) then 
   if (dhunger<1) and (pfood>0) then
    if (dhunger<.2) then
     dhunger+=0.02
     pfood-=0.01   
    else
     if (pfood > 0.4) then
      dhunger+=0.2
      pfood-=0.1
     end
    end
    
    if (pfood<0) then pfood=0 end
   end
   if (dhealth<1) and (pmed>0) then
    dhealth+=0.01
    pmed-=0.01
    if (pmed<0) then pmed=0 end
   end
  end
 else 
  dhdraw=false
 end
 
 
 //ghost logic is turned off for testing
 //ghost logic exception when moving off screen
 ghost_logic()
 
 if (t%200==0) then
  if not wifeghost then
   if not daughterghost then
    
    if (difficulty=="easy") then
     maxghost=4
    else 
     set_max_ghost()
    end
    if (#ghosts<maxghost) then
     populate_ghost()
    end
   end
  end
 end
 
 //ghost collision
 for g in all(ghosts) do
  if (g.x==px) and (g.y==py) then
   if (g.spr==132) then
    txt1="the spirit of your dead wife"
    txt2="can no longer rest in peace."
    txt3=""
    if (difficulty=="hard") then
     phealth-=0.04
     sfx(0)
    end 
   elseif (g.spr==133) then
    txt1="you daughter's spirit will now"
    txt2="forever wander in aimless"
    txt3="limbo."
    if (difficulty=="hard") then
     phealth-=0.04
     sfx(0)
    end 
   else
    if (difficulty=="easy") then
     if (t%5==0) then
      phealth-=0.01
     end
    elseif (difficulty=="normal") then
     phealth-=0.02
    else
     phealth-=0.04
    end
    sfx(0)
   end
  end
 end
 
 //daughter abbey's health
 // and hunger drain.
 if (dalive) then
  if (t%500==0) and dsick then
   dhealth-=dhd
  end
  if (t%400==0) then
   dhunger-=dhungerd
   if (dhunger<=0) then
    dhunger=0
    dhealth-=dhd*3
    txt1="your daughter is starving."
    txt2,txt3="",""
   end
   if (dhealth<=0.10) then
    txt1="abbey is about to die. she"
    txt2,txt3="desprately needs medicine.",""   
   end
  end
 end

 
 //hurt bob if food 0
 if (t%400==0) then
  pfood-=dhungerd
  if (pfood<=0) then
   pfood=0
   phealth-=0.10
   txt1="you're starving."
   txt2=""
   txt3=""
  end
 end

 //kill bob
 if (phealth<=0) then
  phealth=0
  if (row==town) then
   gtown=ghosts
  end
  gmode="dead"
  offset=1.5
   
  //add grave
  local a=5 //y
  local q=town[a]
  local b=12 //x
  q[b]=50
  a=4
  local w=town[a]
  w[b]=52
 end 


end

function draw_stage1()
 cls()
 screen_shake()
 
 local cx=0
 local cy=0
 
 for y=1,11 do
  local currow=row[y]
  for x=1,16 do
   spr(currow[x],cx,cy)
   cx+=8
  end
  cx=0
  cy+=8
 end
 
 //draw ghosts
 for g in all(ghosts) do
  spr(g.spr,g.x,g.y)
  //print(g.x.." "..g.y,g.x,g.y-6,8)
 end

 //have daughter follow with ticket
 if (dticket==1) and (dhealth>0) then
  spr(160,followx,followy)
 end 
 
 if (dwindraw) then
  spr(160,px+8,py)
 end
 
 //draw player
 spr(pspr,px,py)
 //print(px.." "..py,px,py-6,9)
 
 
 draw_bottom()
 
 if ddraw then
  draw_all_bars()
 end 
 
 if drawallbars then
  draw_all_bars()
 end

 if hmdraw then
  draw_all_bars()
 end
 
 if mdraw then
  draw_all_bars()
 end
 
 if fdraw then
  draw_all_bars()
 end
 
 if sdraw then
  draw_all_bars()
 end
 
 if dhdraw then
  draw_all_bars()
 end
 
 if dockdraw then
  draw_all_bars()
 end
 
 //draw corpse parts
  local a=5
  local y=row[a]
  local b=10
  
  local chk=y[b]
  if (chk==10) and not rampage then 
   for p in all (fitems) do
    if (p=="head") then
     local t
     if (daughterhead) then
      t=134
     else
      t=78
     end
     spr(t,8*8+4,8*4)
    elseif (p=="torso") then
     spr(94,8*8+4,8*5)
    elseif (p=="right arm") then
     spr(95,8*9+4,8*5)
    elseif (p=="left arm") then
     spr(93,8*7+4,8*5)
    elseif (p=="right leg") then
     spr(110,8*9+2,8*6)
    elseif (p=="left leg") then
     spr(109,8*8-1,8*6)
    end
    
    if (electric) then
     if (electrictimerstart>0)then
       electrictimerstart-=1
       for i=1,2 do
        for j=1,3 do
         local rand=flr(rnd(4)+135)
          spr(rand,7*8+(i*8),(j*8)+3*8)
        end
       end
     end
     
     if (electrictimerstart<=0) then
      electrictiimerstop-=1
      
       if (electrictiimerstop==0) then
        alivetimer-=1
        if (alivetimer==0) then
         electric=false
         if (difficulty=="easy") then
          txt1="the doctor's experiment failed."
          txt2=""
          txt3=""
         else
          rampage=true
          start_rampage()
          txt1="the abomination excapes its"
          txt2="bonds and flees leaving a wake"
          txt3="of distruction behind it." 
         end
        else
         electrictimerstart=4
         electrictiimerstop=30
         sfx(12)
         txt1="massive amounts of electricity"
         txt2="are surged through the mad"
         txt3="doctor's twisted experiment."
        end
        
       end
      
     end
    end
    
   end
  end
end

function draw_all_bars()
 if (dalive) then
  //daughters health bar
  local ei,eo=8*1.75,8*2.75
  rectfill(0,ei,60,eo,5)
  rectfill(0,ei,60*dhealth,eo,8)
  rect(0,ei,60,eo,7)
  print("abbey's health",2.5,8*2,7)
 
  //daughters hunger bar
  rectfill(65,ei,127,eo,5)
  rectfill(65,ei,65+60*dhunger,eo,8)
  rect(65,ei,127,eo,7)
  print("abbey's hunger",67.5,8*2,7)
  
   //abbey's tickets
  if (dticket==1) then
   rectfill(75,8*.5,122,8*1.5,3)
   rect(75,8*.5,122,8*1.5,7)
   print("ticket "..dticket.."/1",77,8*0.75,7)
  end
 end
 
  //bobs medice
  rectfill(0,8*8.25,60,8*9.25,5)
  rectfill(0,8*8.25,60*pmed,8*9.25,12)
  rect(0,8*8.25,60,8*9.25,7)
  print("snake oil",2,8*8.5,7)
 
  //bobs hunger
  rectfill(65,8*8.25,127,8*9.25,5)
  rectfill(65,8*8.25,65+30*pfood,8*9.25,12)
  rect(65,8*8.25,127,8*9.25,7)
  print("bob's food",67.5,8*8.5,7)

  //bobs money
  rectfill(0,8*9.5,25,8*10.5,0)
  rect(0,8*9.5,25,8*10.5,7)
  print("$"..pmoney,2,8*9.75,7)
  
  //bobs parts
  local partcol=0
  if (#pitems>0) then
   partcol=2
  end
  rectfill(30,8*9.5,70,8*10.5,partcol)
  rect(30,8*9.5,70,8*10.5,7)
  print("parts "..#pitems.."/"..6-#fitems,32,8*9.75,7)

  //bobs tickets
  local tcol=0
  if (ptickets>0) then
   tcol=3
  end
  rectfill(75,8*9.5,122,8*10.5,tcol)
  rect(75,8*9.5,122,8*10.5,7)
  if (dticket==1) then
   print("tickets "..ptickets.."/1",77,8*9.75,7)
  else
   print("tickets "..ptickets.."/2",77,8*9.75,7)
  end
 

end

function ghost_logic()
 for g in all(ghosts) do
  local cgx=g.x
  local cgy=g.y
 
  if (t%20==0) then
   if (g.dir==0) then
    g.x-=8
   elseif (g.dir==1) then
    g.x+=8
   elseif (g.dir==2) then
    g.y-=8
   elseif (g.dir==3) then
    g.y+=8
  end
  
  local gt=get_gtile(g)
  if check_gtile(gt) then
   g.x,g.y=cgx,cgy
  end
  //stay in bounds
  if (g.x>129) then
   g.x=cgx
  end
  if (g.x<1) then
   g.x=cgx
  end
  if (g.y>129) then
   g.y=cgy
  end
  if (g.y<1) then
   g.y=cgy
  end  
  
  //new direction
  local r=flr(rnd(4))
  g.dir=r
  end
  
 end

end

function check_gtile(gt)
 if (gt==41) or (gt==37) or (gt==36) or (gt==35) or (gt==19) or (gt==20) or (gt==21) or (gt==52) or (gt==49) or (gt==33) or (gt==32) or (gt==34) or (gt==63) or (gt==62) or (gt==61) then
  return true
 else 
  return false
 end
end

function start_rampage()
 local a=5 //y
 local q=lab[a]
 local b=8 //x
 q[b]=139
 b+=1
 q[b]=141
 b-=1
 a=6
 local w=lab[a]
 w[b]=140
 b+=2
 w[b]=141
 b-=1
 w[b]=56
 offset=2
 sfx(8)
 if (difficulty=="normal") then
  phealth-=.40
 else
  phealth-=.80
 end
 if (dticket==1) then
  dhealth=0
 end
end

function set_follow()
 followx=px
 followy=py
end



function cleanandfollow()

  local p=5 //y
  local k=home[p]
  local o=9 //x
  k[o]=56

end
-->8
function rand_grave()
 //special reward for family graves
 local gp=get_ptile()
 if (gp==129) then 
  //wifes grave
  add(jitems,"wife's ring")
  txt1="amoung your wife's bones you"
  txt2,txt3="find the wedding ring you","gave her long ago."
  wifeghost=true
  dugupgraves+=1
  sfx(9)
 elseif (gp==131) then
  while (#items>0) do
   local item=items[1]
   if (item=="head") then daughterhead=true end
   del(items,item)
   add(pitems,item)
   txt1="sidisticly, you dismember your"
   txt2="daughter's corpse. the doctor"
   txt3="will only accept body parts."
   daughterghost=true
   dugupgraves+=1
   sfx(6)
  end
 elseif (gp==158) then
  sfx(9)
  txt1="you've discovered a small bag"
  txt2="of shiny gold doubloons. how"
  txt3="fortunate!"
  foundtreasure=true
  add(jitems,"gold doubloons")
 else
  //random reward or failure
  local r = flr(rnd(10))
  dugupgraves+=1
  local ease
  if (difficulty=="easy") then
   ease=4
  else 
   ease=2
  end
  if (r<ease) then
   get_item()
  elseif (r<4) then
   get_hurt()
  else
   get_junk()
  end 
 end
 //no open grave for beach loot
 if (gp==158) then
  set_ptile(143)
 else
  set_ptile(51)
 end 
end

function get_item()
 if (#items>0) then
  local r=flr(rnd(#items))+1
  local item=items[r]
  del(items,item)
  add(pitems,item)
  txt1="wow, a usable "..item.."."
  txt2,txt3="the doctor might pay well for","this! "
  sfx(6)
 else
  txt1="the grave was empty?!"
  txt2,txt3="",""
 end
end

function get_hurt()
 local r=flr(rnd(3)+1)
 if r==1 then
  txt1="opening the grave releases a"
  txt2="cloud of miasma that chokes"
  txt3="the life out of you!"
  phealth-=0.23
  offset=.35
  sfx(2)
 elseif r==2 then
  txt1,txt2,txt3="nothing but a pile of bones.","",""
 elseif r==3 then 
  txt1="the casket was full of vicious"
  txt2="rats! they bite at your"
  txt3="ankles."
  phealth-=0.07 
  offset=0.25
  sfx(4)
 end 
end

function get_junk()
  local jlist={"pocket watch","dull ring","copper coin","lead tooth","necklace","broach"}
  
  local r=flr(rnd(#jlist)+1)
  local item=jlist[r]
  
  add(jitems,item)
  txt1="you pilfer a"
  txt2,txt3=item..".",""
  sfx(3)
end
-->8
//intro

function update_intro()
 button-=1
 
 if btn(4) and (t>10) then
  gmode="txt"
  if (difficulty=="easy") then
   dhunger=0.9
   dhealth=.95
   dhd=0.02
   dhungerd=0.02
   gdif=80
   phealth=1
   pmoney=60
  elseif (difficulty=="normal") then
   dhunger=0.8
   dhealth=0.8
   dhd=.1
   dhungerd=0.1
   gdif=50
   pfood=1.5
   pmoney=50
  else
   dhunger=0.7
   dhealth=0.65
   dhd=.17
   dhungerd=0.1
   gdif=100
   pfood=1
  end
 end
 if (blood<11) then
  blood+=.15
 end
 
 if btn(0) and (button<=0) then
  button=8
  if (difficulty=="normal") then
   difficulty="easy"
   dcol1=11
   dcol2=5
   dcol3=5
  elseif (difficulty=="hard") then
   difficulty="normal"
   dcol1=5
   dcol2=10
   dcol3=5
  end
 end
 
 if btn(1) and (button<=0) then
  button=8
  if (difficulty=="normal") then
   difficulty="hard"
   dcol1=5
   dcol2=5
   dcol3=8
  elseif (difficulty=="easy") then
   difficulty="normal"
   dcol1=5
   dcol2=10
   dcol3=5
  end
   
 end
 
end

function draw_intro()
 cls()
 
  print("'steal from the dead,",15,70,3)
 print("keep your family fed.'",25,78,3)
 
 draw_blood()
 
 rect(0,8*11,127,114,7)
 //31 charaters of text per line max
 print("use arrows to change difficulty",2.5,8*11+3,6)
 print("press 'z' to start",2.5,8*12+3,6)
 print("easy",22.5,8*13+3,dcol1)
 print("normal",55.5,8*13+3,dcol2)
 print("hard",90.5,8*13+3,dcol3) 
end



function draw_blood()
 circfill(10,10,10,8)   
 circfill(100,30,15,8) 
 circfill(60,30,17,8) 
 circfill(84,32,15,8) 
 circfill(25,24,17,8) 
 circfill(120,53,5,8)  
 circfill(33,35,22,8) 
 circfill(40,32,12,8) 
 circfill(70,12,11,8) 
 circfill(90,20,12,8) 
 circfill(95,42,20,8) 
 circfill(10,52,4,8) 
 circfill(105,8,2,8)
 
 
 rectfill(20,40,22,45+blood,8)
 circfill(21,45+blood,2,8)
 
 rectfill(51,40,51,40+blood,8)
 circfill(51,40+blood,1,8)
 rectfill(65,40,67,44+blood,8)
 circfill(66,44+blood,2,8)

 rectfill(90,40,92,54+blood,8)
 circfill(91,54+blood,3,8)

 rectfill(29,40,29,53+blood,8)
 circfill(29,53+blood,1,8)
 rectfill(109,51,111,51+blood,8)
 circfill(110,51+blood,2,8)

 rectfill(38,40,40,54+blood,8)
 circfill(39,54+blood,3,8)
  
 rectfill(5,20,5,13+blood,8)
 circfill(5,13+blood,1,8)

 spr(64,10,15,13,4)
 print("robert",85,50,11)
end
-->8
//dead
function update_dead()
 ghosts=gtown
 ghost_logic()
 txt1="you are dead."
 txt2="press 'z' button to restart"
 txt3=""
 if btn(4) then
  _init()
  gmode="intro"
 end
end

function draw_dead()
 cls()
 screen_shake()
 row=town
 local cx=0
 local cy=0
 
 for y=1,11 do
  local currow=row[y]
  for x=1,16 do
   spr(currow[x],cx,cy)
   cx+=8
  end
  cx=0
  cy+=8
 end
 
 //draw ghosts
 for g in all(ghosts) do
  spr(g.spr,g.x,g.y)
  //print(g.x.." "..g.y,g.x,g.y-6,8)
 end
 
 draw_bottom()
end
-->8
function update_txt()
 txty-=0.25
 if (blood<11) then
  blood+=.15
 end

 if btn(0) or btn(1) or btn(2) or btn(3) or btn(5) then
  txtcount=15
 end
 
 if btn(4) and (txty<115) then
  gmode="stage1"
  row=town
  px,py=8*12,8*8
  sfx(20)
  bprsd=0
 end
 if (txty<-230) then
  gmode="stage1"
  row=town
  px,py=8*12,8*8
  sfx(20)
  bprsd=0
 end
end

function populate_introtxt()
 credits={}
 
 add(credits, "you are robert brokeshovel,")
 add(credits, "5th generation graverobber.")
 add(credits, "")
 add(credits, "the winter of 15xx was a")
 add(credits, "difficult year for the town")
 add(credits, "of marienbad. cholera had cut")
 add(credits, "short the lives of many.")
 add(credits, "")
 add(credits, "one of those victims was")
 add(credits, "robert's beloved wife sarah,")
 add(credits, "which left robert to raise")
 add(credits, "their daughter on his own.")
 add(credits, "")
 add(credits, "now, five years later, robert")
 add(credits, "dreams of fleeing marienbad")
 add(credits, "and emigrating to america")
 add(credits, "with his daughter abbey.")
 add(credits, "")
 add(credits, "unfortunately, she has recently")
 add(credits, "fallen ill and become bedridden.")
 add(credits, "")
 add(credits, "robert's only hope to save his")
 add(credits, "daughter and buy passage to")
 add(credits, "the new world is by selling")
 add(credits, "whatever he can scavange")
 add(credits, "from the dead.")
 
end

function draw_txt()
 //reuse code
 draw_win()
 populate_introtxt()
  
 if (txtcount>0) then
  print("'z' to skip",85,0,12)
  txtcount-=1
 end

end
-->8
function create_ghost(x,y,s)
 local g={}
 g.life=rnd(8000)+1000
 g.x=(x-1)*8
 g.y=(y-1)*8
 if (s==132) or (s==133) then
  g.starty=y+1
 else
  g.starty=y
 end
 g.startx=x
 g.dir=flr(rnd(3))
 g.spr=s
 
 return g
end

function set_max_ghost()
 local cx=0
 local cy=0
 maxghost=0
 
 for y=1,11 do
  local currow=row[y]
  for x=1,16 do
   if (currow[x]==51) then
    maxghost+=1
   end
   cx+=8
  end
  cx=0
  cy+=8
 end
end

function populate_ghost()
 local cx=0
 local cy=0
 local limit=0
 for y=1,11 do
  local currow=row[y]
  for x=1,16 do
   if (currow[x]==51) then
    local ran=flr(rnd(100))
    if (ran<gdif) then
     if (#ghosts<maxghost) and (limit==0) then
      local match=true
      
      for h in all (ghosts) do
       if (h.startx==x) and (h.starty==y) then
        match=false
       end
      end
      if (match) then
       limit=1
       add(ghosts,create_ghost(x,y,17))
       local ran=flr(rnd(4)+21)
       sfx(ran)
      end
      
     end
    end
   end
   cx+=8
  end
  cx=0
  cy+=8
 end
end
-->8
//win credits
function update_win()
 txty-=0.25
 
 local sw=0-(#credits*9)
 if (txty<sw) then
  _init()
  gmode="intro"
 end
end

function draw_win()
 cls()
 draw_blood()
 local i=0
 for p in all (credits) do
  print(p,txtx,txty+(txto*i),tc)
  i+=1
 end 
end

function add_credit()
 credits={}
 add(credits, "as the steamer pulls away")
 add(credits, "from the dock you mull over")
 add(credits, "your recent behavior.")
 add(credits, "")
 
 
 if wifedissed then
  add(credits, "you desecrated your wife's")
  add(credits, "grave and caused her spirit to")
  add(credits, "roam eternally in limbo.")   
  add(credits,"")
  if ringsold then
   add(credits,"then you sold her cherrished")
   add(credits,"wedding ring.")
   add(credits,"")
  end
 end
 
 if not dalive then
  add(credits, "you were unable to save your")
  add(credits, "daughter abbey.")
  add(credits,"")
 end
 
 if not dsick then
  if dwindraw then
   add(credits,"you were able to heal your")
   add(credits,"daughter and bring her to")
   add(credits,"america. your dream realized.")
   add(credits,"")
  else
   if (dhealth>=0) then
    add(credits,"leaving for america without")
    add(credits,"abbey was a tough decision,") 
    add(credits,"but it was for the best.") 
   else
    add(credits,"even though abbey initially")
    add(credits,"recovered, she died")
    add(credits,"eventually anyway.")
   end
   add(credits,"")
  end
 end

 if daughterdissed then
  add(credits, "when your daughter died you")
  add(credits, "decided to dig up her") 
  add(credits, "corpse. are you ok?")  
  add(credits,"")
 end
  
 if (#fitems>0) then
  add(credits,"all said, you looted "..dugupgraves.." graves") 
  add(credits, "and sold "..#fitems.. " body parts to the")
  add(credits, "mad doctor for experimentation.")
  if (#fitems==6) then
   add(credits,"you didn't realize he would try")
   add(credits,"creating new life!")

   if daughterhead then
    add(credits, "")
    add(credits, "the worst part was when he")
    add(credits, "bolted abbey's head on to")
    add(credits, "the monstrosity, but that's")
    add(credits, "your fault really.")
   end
   add(credits,"")

   if (difficulty=="easy") then
    add(credits, "thankfully, the experiment was")
    add(credits, "a failure.")
   else
    add(credits,"he was able to reanimate the")
    add(credits,"corpse with horrifying results.")
    add(credits,"the thing nearly killed you.")
   end 
   add(credits,"")
  end
 end
 
 if foundtreasure then
  add(credits,"you also found some pirate")
  add(credits,"treasure on the beach, which")
  add(credits,"seems amazingly lucky.")
  add(credits,"")
 end
 
 if (#pitems>0) then
  add(credits,"when the other passengers")
  add(credits,"discovered you brought human")
  add(credits,"body parts on the ship they")
  add(credits,"tossed you overboard.") 
  add(credits,"")
 end
 add(credits,"the end")
 add(credits,"")
 add(credits,"time in seconds: "..ftime/30)
 add(credits,"difficulty: "..difficulty)
 add(credits,"")
 add(credits,"created by tonysoft.")
 add(credits,"october 2020")
 
end
__gfx__
000000000006f000000000000006f000441114444477777444444444444444444777777444aaaa4466666666444aaa4446666664505050504544444445444444
00000000050ff0000006f000000ff07051ff1555557aaa7555555755556666555777777555affa5567677676555aff5556777365050505054444445444444454
0070070005888800000ff0000088850041ff1444447afa7444483884444664444eeeeee444affa44666666664444f444463bbb64505050504445444444454444
0007700008088800008588000808580011dd1155557a1a7555222287556bb6555eeeeee555222255676666765577777556bbbb65050505054444444444444444
0007700005099000008858000085900012222144477888774222384446b333644eeeeee44f4224f4676666764f47774f46bb3b64505050504444454444444544
0070070005022000000995800052200011222115777ccc77757285555633b3655eeeeee555577555666666665055655056bbbb65050505054544444445444444
0000000007020200000222500002020012212214447bbb7447444444446336444eeeeee444222244676776764447774446b3bb64505050504444444444444444
00000000000202000002020600020200122122115577577555755555555665555eeeeee552222225666666665550505555666655050505054444444444444444
00077700007770003333333333333336666666666333333333333333333333335555555555555555444444444616666450505050505050508888888866666666
0007770007676700333aa3b33333336777777777763333b3333888b333aaa3b36656666560000005555555555677716505050505050505058505050865050506
000070000686860033baa33333b33677777777777763333333388233339aa33355555555507ccc054444444446cccc6450505050505050508050505860505056
00777770776767703aaaaaa33333677777777777777633333332883333aa93336666566660cc7c065555555556c1cc6505050505050505058505050865050506
07077707077577003aaaaaa33b36777777777777777763333b33b3333b3b33335555555550c77c054444444446cccc6450505050505050508050505860505056
0700700700767000333aa3b33367777777777777777776b33333bbb3333bb3336656666560cccc055555555556ccc16505050505050505058505050865050506
0007070000077000333aa333367777777777777777777763333bb33333bb333355555555500000054444444446c1cc6450505050505050508050505860505056
0007070000007700333aa3336777777777777777777777763333b333333b33336666566666665666555555555566665505050505050505058505050865050506
999999994544444422222222677777776666666677777776777777777777777744dddd4455555555888888885555555545444444454444444544444446554564
ff9ffff9444444545222222267777777650505067777777677777777766666674dccccd488588885850505088000000544444454444444544444445444465644
9999999944454444222222226777777760505056777777767777777776012367dccccccd5555555580505058507ccc0544454444444544444445444446556454
ffff9fff44444444222222626777777765050506777777767777777776456767ddccccdd888858888505050880cc7c0844444444444444444444444444564544
999999994444454422222222677777776050505677777776777777777689ab67d5dddd5d555555558050505850c77c0544444544444445444444454445655654
ff9ffff922222222222222226777777765050506777777767777777776cbef67ddd5d5dd885888858505050880cccc0545444444454444444544444444565564
99999999666666665222222267777777605050567777777677777777766666674d5d5dd455555555805050585000000544444444444444444444444446554654
ffff9fff2222222222222222677777776505050677777776777777777777777744dddd4488885888850505088888588844444444444444444444444445465454
454444443333333344444444444444444444444445444444454444440000000044444444999999994777777447aaaa7450505050505050504655456446554564
44444454333333b3441515144004040445466444444aaa544488845400000000555555559ffffff95777777557affa7505050505050505054446564444465644
4445444433b33333454151444400000444666654444a2a44448e844400000000444444449ffffff9488888844eaffae450505050505050504655645446556454
4444444433333333441515544000000444655644444aaa444488844400000000555555559ffffff9588888855ea22ae505050505050505054456454444564544
444445443b333333415141544400000444666644444435444443454400000000444444449ffffff9488888844e2222e450505050505050504565565445655654
45444444333333b3414515444000004444666644454333444533344400000000555555559ffffff9588888855e2222e505050505050505054456556444565564
44444444333b3333445454144400000446666664444434444443444400000000444444449ffffff9488888844e2222e450505050505050504655465446554654
44444444333333334444444444444444444444444444444444444444000000005555555599999999588888855e2222e505050505050505054546545445465454
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000800000000000000
000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000022f0000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000802ffff000000000
000000000000000000000000000000000000000000000000000000000000000000000000000000000000002222220000000000000000000000f7f7f000000000
000000002222000000000000000000000000000000000000000000000000220000000000000000220002222222222222222222200000000000fffff000000000
000000002222222200000000022000000000000000000002200000000000220000000000000000220002222200022222222222200000000000ffeff000000000
0000000022222222222200222222222222222000000002222000000000002200000000000000022200022200000000000000000000000000000fff0800000000
00000002220222222220002222222222222222000000022222000000000022200000000000000222000022200000000000000000000000000080280000000000
00000002220000222220000002200000000222000000022222200000000022200000000000000220000002200000000000000000000000000000008000800000
00000022200000000000000002200000000022000002222002220000000002200000000000000220000002200000000000000000000000000008f00000000000
00000022200000000000000002200000000002200002222002220000000002220000000000000220000002200000000000000000000004f802fffff80f400000
0000022220000000000000000220000000000220000222200022000000000222000000000000022000000220000000000000000000004ff08feffef08ff20000
000002220000000000000000022000000000002000022200002220000000002220000000000002200000022000000000000000000000ff0200ffff0800ff0000
000022200000000000000000022000000000002000022200000220000000002222000000000022200000022000000000000000000000f000004fff00000f0000
000022000000000000000000022000000000222000022200000222000000000222000000000022200000022200000000000000000000ff000004f00000ff0000
000222000000000000000000022000000022222000022000000222000000000022200000000022000000222222222200000000000000ff000800800000ff0000
000222000000222222000000022000020222200000222000000022200000000022220000000222000000222222222200000000000000080080800000bbbbbbbb
000222000000222222222220022022222222000000222000000022200000000002220000000222000000222222222220000000000000ed080ed00000b7bbbbbb
000222000000000022222220022222222220000000222200222222222200000000222000002220000000222222222220000000000000ff8082d00000bbbbb7bb
000222000000000000222022002200022200000000222222222222222200000000222200002200000000220000000000000000000000ff000ff00000bbbbbbbb
0002220000000000002220220222000022200000002200000000022000000000000222000222000000022200000000000000000000000f000ff00000bb7bbbbb
0000220000000000000220220222000002220000022200000000022200000000000022000222000000022200000000000000000000000ff00df00000bbbbbbbb
00002200000000000002202202200000000220000222000000000022200000000000222022200000000220000000000000000000000000f00df00000bbb7bb7b
0000220000000000002200220220000000002200022000000000002220000000000022202220000000022000000000000000000000000ff00fff0000bbbbbbbb
00002220000000000022002202200000000002200220000000000002220000000000022222000000000220000000000000000000000000004655456444444444
00000222200000000220022002200000000002200220000000000002220000000000022220000000000220000000000000000000000000004446564454465546
00000022222000022220022000200000000002200220000000000000220000000000022200000000000222000000000000000000000000004655645456555655
00000002222222222200000000000000000000200220000000000000220000000000022200000000000022222220000000022220000000004456454454564564
00000000022222222000000000000000000000000000000000000000222000000000022200000000000022222222222220222220000000004565565465655655
00000000000000000000000000000000000000000000000000000000022000000000022200000000000022222222222222222000000000004456556454565556
00000000000000000000000000000000000000000000000000000000022000000000000000000000000022200000000022200000000000004655465446456454
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000004546545444444444
333333334444444447777774444444440007770000555500080aaa000000c00c000c070000000000c700000044444444cc4ccccc66666666ccccccccffffffff
333333b3441515145777777544151514000c7c000056650000a22fa000070c00c00000000c00007000c00000565555555c6ccc5c57577676ccc7c7ccffffff4f
33b33333454151444eeeeee4454151440007e700005665008a2ffffa0000c07000700000000c00000000c0c04644444444c4c64644466666c7ccccccff4fffff
33333333441515545eeeeee54415155400667660002222000afcfcfa00000c000c00c00000007c00000c700056656565c555c55555556676cccc7cccffffffff
3b333333415141544eeeeee44151415407066607060220600afffffa0c0700c0000007000700000000c0000046666564446444c444444676cc7ccc7cffffffff
333333b3414515445eeeeee54145154407006007000660000aff8ffa707070000000c000000c000000007c00566cc1655555555555556666ccccccccfffff4ff
333b3333445454144eeeeee44454541400066600002222000aafffa80c000c000070c0c00007cc000000007046c1cc644444c44444674676c7ccc7ccf4ffffff
33333333444444445eeeeee54444444400666660022222200a8a28aac0000000000000000000000000000c0c556666565c55555555566666ccccccccffffffff
45444444545454545454545454545454ffffffffccccccccccccccccc046660066640cccc004d4444d400ccc545aaa54fffffffcfffffffcffffffff45444444
44444454545454545454545454545454ffffff4fc7ccc7ccccccc7cc22466055066407cccc04d4444d40c7cc545ffa54fffffffcfffffffcfffff4ff44444454
44454444545454545454545454545454ff4fffffccc10000000ccccc2246605506640ccccc0444444440cccc5454f454ff4fffccff4fffccfff4ffff44454444
44444444545454545454545454545454ffffffffcc0011111100ccccc046680086640ccccc00444444007ccc54f7f7f4ffffffccffffffccffffffff44444444
44444544545454545454545454545454ffffffffcc0555555550cc7cc044668866640c7ccc700444400ccc7c5f57775ffffffffcfffffffcffffffff44444544
45444444545454545454545454545454fffff4ffcc0000000000ccccc044666666440ccccccc004400cccccc5f54145ffffff4fcfffff4fcfffff9ff45444444
44444444545454545454545454545454f4ffffffc0044444444007ccc044d4444d4407ccc7ccc00007ccc7cc54515154f4fffffcf4fffffcf4ffffff44444444
44444444fff4fff4ccc4ccc454545454ffffffffc041166661140cccc044144441440ccccccccccccccccccc54515154ffffffccffffffccffffffff44444444
00aaaa00666666660000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00affa00655555560000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00affa00655555560000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00222200656556560000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0f0220f0656556560000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000655555560000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00222200655555560000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
02222220655555560000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__label__
33333333333333333333333333333333333333333333333333333333333333334655456433333333333333333333333333333333333333333333333333333333
333333b3333333b3333333b3333333b3333333b3333333b3333333b3333333b344465644333333b3333333b3333333b3333333b3333333b3333333b3333333b3
33b3333333b3333333b3333333b3333333b3333333b3333333b3333333b333334655645433b3333333b3333333b3333333b3333333b3333333b3333333b33333
33333333333333333333333333333333333333333333333333333333333333334456454433333333333333333333333333333333333333333333333333333333
3b3333333b3333333b3333333b3333333b3333333b3333333b3333333b333333456556543b3333333b3333333b3333333b3333333b3333333b3333333b333333
333333b3333333b3333333b3333333b3333333b3333333b3333333b3333333b344565564333333b3333333b3333333b3333333b3333333b3333333b3333333b3
333b3333333b3333333b3333333b3333333b3333333b3333333b3333333b333346554654333b3333333b3333333b3333333b3333333b3333333b3333333b3333
33333333333333333333333333333333333333333333333333333333333333334546545433333333333333333333333333333333333333333333333333333333
33333333454444444544444444444444454444444444444445444444444444444655456445777444444444444544444444444444454444444444444433333333
333333b34444445444444454454664444444445445466444444444544546644444465644476767544546644444444454454664444444445445466444333333b3
33b33333444544444445444444666654444544444466665444454444446666544655645446868644446666544445444444666654444544444466665433b33333
33333333444444444444444444655644444444444465564444444444446556444456454477676774446556444444444444655644444444444465564433333333
3b33333344444544444445444466664444444544446666444444454444666644456556544775774444666644444445444466664444444544446666443b333333
333333b34544444445444444446666444544444444666644454444444466664444565564457674444466664445444444446666444544444444666644333333b3
333b33334444444444444444466666644444444446666664444444444666666446554654444774444666666444444444466666644444444446666664333b3333
33333333444444444444444444444444444444444444444444444444444444444546545444447744444444444444444444444444444444444444444433333333
333333334544444445444444447774444544444444444444454444444446f4444655456445444444444444444544444444444444454444444444444433333333
333333b3448884544444445447676714444444544004040444444454450ff40444465644444444544004040444444454441515144444445444151514333333b3
33b33333448e84444445444446868644444544444400000444454444458888044655645444454444440000044445444445415144444544444541514433b33333
33333333448884444444444477676774444444444000000444444444480888044456454444444444400000044444444444151554444444444415155433333333
3b33333344434544444445444775775444444544440000044444454445099004456556544444454444000004444445444151415444444544415141543b333333
333333b34533344445444444417675444544444440000044454444444502204444565564454444444000004445444444414515444544444441451544333333b3
333b33334443444444444444445774144444444444000004444444444702020446554654444444444400000444444444445454144444444444545414333b3333
33333333444444444444444444447744444444444444444444444444444242444546545444444444444444444444444444444444444444444444444433333333
33333333454444444544444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444433333333
333333b34444445444444454544655465446554654465546544655465446554654465546544655465446554654465546544655465446554654465546333333b3
33b33333444544444445444456555655565556555655565556555655565556555655565556555655565556555655565556555655565556555655565533b33333
33333333444444444444444454564564545645645456456454564564545645645456456454564564545645645456456454564564545645645456456433333333
3b33333344444544444445446565565565655655656556556565565565655655656556556565565565655655656556556565565565655655656556553b333333
333333b34544444445444444545655565456555654565556545655565456555654565556545655565456555654565556545655565456555654565556333333b3
333b33334444444444444444464564544645645446456454464564544645645446456454464564544645645446456454464564544645645446456454333b3333
33333333444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444433333333
33333333444444444544444444444444454444444444444445444444444444444655456445444444444444444544444444444444454444444544444433333333
333333b34546644444444454454664444444445445466444444444544546644444465644444444544546644444444454454664444444445444444454333333b3
33b33333446666544445444444666654444544444466665444454444446666544655645444454444446666544445444444666654444544444445444433b33333
33333333446556444444444444655644444444444465564444444444446556444456454444444444446556444444444444655644444444444444444433333333
3b33333344666644444445444466664444444544446666444444454444666644456556544444454444666644444445444466664444444544444445443b333333
333333b34466664445444444446666444544444444666644454444444466664444565564454444444466664445444444446666444544444445444444333333b3
333b33334666666444444444466666644444444446666664444444444666666446554654444444444666666444444444466666644444444444444444333b3333
33333333444444444444444444444444444444444444444444444444444444444546545444444444444444444444444444444444444444444444444433333333
33333333444444444544444444444444454444444444444445444444444444444655456445444444444444444544444444444444454444444544444433333333
333333b34415151444444454441515144444445440040404444444544415151444465644444444544004040444444454441515144444445444444454333333b3
33b33333454151444445444445415144444544444400000444454444454151444655645444454444440000044445444445415144444544444445444433b33333
33333333441515544444444444151554444444444000000444444444441515544456454444444444400000044444444444151554444444444444444433333333
3b33333341514154444445444151415444444544440000044444454441514154456556544444454444000004444445444151415444444544444445443b333333
333333b34145154445444444414515444544444440000044454444444145154444565564454444444000004445444444414515444544444445444444333333b3
333b33334454541444444444445454144444444444000004444444444454541446554654444444444400000444444444445454144444444444444444333b3333
33333333444444444444444444444444444444444444444444444444444444444546545444444444444444444444444444444444444444444444444433333333
33333333444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444457774444544444433333333
333333b35446554654465546544655465446554654465546544655465446554654465546544655465446554654465546544655464767675444444454333333b3
33b33333565556555655565556555655565556555655565556555655565556555655565556555655565556555655565556555655468686444445444433b33333
33333333545645645456456454564564545645645456456454564564545645645456456454564564545645645456456454564564776767744444444433333333
3b33333365655655656556556565565565655655656556556565565565655655656556556565565565655655656556556565565547757744444445443b333333
333333b35456555654565556545655565456555654565556545655565456555654565556545655565456555654565556545655564576744445444444333333b3
333b33334645645446456454464564544645645446456454464564544645645446456454464564544645645446456454464564544447744444444444333b3333
33333333444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444477444444444433333333
33333333454444444544444445444444454444444444444445444444444444444655456445444444444444444544444444444444454444444544444433333333
333333b34444445444444454444444544488845445466444444444544546644444465644444444544546644444444454454664444444445444444454333333b3
33b33333444544444445444444454444448e84444466665444454444446666544655645444454444446666544445444444666654444544444445444433b33333
33333333444444444444444444444444448884444465564444444444446556444456454444444444446556444444444444655644444444444444444433333333
3b33333344444544444445444444454444434544446666444444454444666644456556544444454444666644444445444466664444444544444445443b333333
333333b34544444445444444454444444533344444666644454444444466664444565564454444444466664445444444446666444544444445444444333333b3
333b33334444444444444444444444444443444446666664444444444666666446554654444444444666666444444444466666644444444444444444333b3333
33333333444444444444444444444444444444444444444444444444444444444546545444444444444444444444444444444444444444444444444433333333
33333333454444444544444445444444454444444444444445444444444444444655456445444444444444444544444444444444454444444544444433333333
333333b3444aaa5444444454444444544444445444151514444444544415151444465644444444544415151444444454441515144444445444888454333333b3
33b33333444a2a44444544444445444444454444454151444445444445415144465564544445444445415144444544444541514444454444448e844433b33333
33333333444aaa444444444444444444444444444415155444444444441515544456454444444444441515544444444444151554444444444488844433333333
3b33333344443544444445444444454444444544415141544444454441514154456556544444454441514154444445444151415444444544444345443b333333
333333b34543334445444444454444444544444441451544454444444145154444565564454444444145154445444444414515444544444445333444333333b3
333b33334444344444444444444444444444444444545414444444444454541446554654444444444454541444444444445454144444444444434444333b3333
33333333444444444444444444444444444444444444444444444444444444444546545444444444444444444444444444444444444444444444444433333333
33333333454444444544444445444444454444444444444444444444444444444444444444444444444444444444444444444444454444444544444433333333
333333b34444445444444454444444544444445454465546544655465446554654465546544655465446554654465546544655464444445444444454333333b3
33b33333444544444445444444454444444544445655565556555655565556555655565556555655565556555655565556555655444544444445444433b33333
33333333444444444444444444444444444444445456456454564564545645645456456454564564545645645456456454564564444444444444444433333333
3b33333344444544444445444444454444444544656556556565565565655655656556556565565565655655656556556565565544444544444445443b333333
333333b34544444445444444454444444544444454565556545655565456555654565556545655565456555654565556545655564544444445444444333333b3
333b33334444444444444444444444444444444446456454464564544645645446456454464564544645645446456454464564544444444444444444333b3333
33333333444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444433333333
33333333333333333333333333333333333333333333333333333333333333334655456433333333333333333333333333333333333333333333333333333333
333333b3333333b3333333b3333333b3333333b3333333b3333333b3333333b344465644333333b3333333b3333333b3333333b3333333b3333333b3333333b3
33b3333333b3333333b3333333b3333333b3333333b3333333b3333333b333334655645433b3333333b3333333b3333333b3333333b3333333b3333333b33333
33333333333333333333333333333333333333333333333333333333333333334456454433333333333333333333333333333333333333333333333333333333
3b3333333b3333333b3333333b3333333b3333333b3333333b3333333b333333456556543b3333333b3333333b3333333b3333333b3333333b3333333b333333
333333b3333333b3333333b3333333b3333333b3333333b3333333b3333333b344565564333333b3333333b3333333b3333333b3333333b3333333b3333333b3
333b3333333b3333333b3333333b3333333b3333333b3333333b3333333b333346554654333b3333333b3333333b3333333b3333333b3333333b3333333b3333
33333333333333333333333333333333333333333333333333333333333333334546545433333333333333333333333333333333333333333333333333333333
77777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777
70000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000007
70000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000007
70606006606060000066606660600066606660666000006660000000000000000000000000000000000000000000000000000000000000000000000000000007
70606060606060000060600600600060006000606000006060000000000000000000000000000000000000000000000000000000000000000000000000000007
70666060606060000066600600600066006600660000006660000000000000000000000000000000000000000000000000000000000000000000000000000007
70006060606060000060000600600060006000606000006060000000000000000000000000000000000000000000000000000000000000000000000000000007
70666066000660000060006660666060006660606000006060000000000000000000000000000000000000000000000000000000000000000000000000000007
70000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000007
70000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000007
70000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000007
70066006606000660000006660066006606660606000000000000000000000000000000000000000000000000000000000000000000000000000000000000007
70600060606000606000000600606060600600606000000000000000000000000000000000000000000000000000000000000000000000000000000000000007
70600060606000606000000600606060600600666000000000000000000000000000000000000000000000000000000000000000000000000000000000000007
70606060606000606000000600606060600600606000000000000000000000000000000000000000000000000000000000000000000000000000000000000007
70666066006660666000000600660066000600606000000000000000000000000000000000000000000000000000000000000000000000000000000000000007
70000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000007
70000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000007
70000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000007
70000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000007
70000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000007
70000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000007
70000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000007
70000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000007
70000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000007
70000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000007
77777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
77777777777777777777777777777777777777777777777777777777777770000777777777777777777777777777777777777777777777777777777777777777
78888888888888888888888888888888888000000000000000000000000070000788888888888888888888888888888888888888880000000000000000000007
78bbb88bb8bbb88b888bb88888b8b8bbb8bbb0b000bbb0b0b000000000007000078bbb8bb888bb8b8b8bbb8bbb8bbb8bbb8bb888bb0bbb000000000000000007
78b8b8b8b8b8b8b888b8888888b8b8b888b0b0b0000b00b0b000000000007000078b888b8b8b888b8b8bbb8b8b8b8b8b888b8b8b880b00000000000000000007
78bb88b8b8bb888888bbb88888bbb8bb88bbb0b0000b00bbb000000000007000078bb88b8b8b888b8b8b8b8bb88bb88bb88b8b8b880bb0000000000000000007
78b8b8b8b8b8b8888888b88888b8b8b888b0b0b0000b00b0b000000000007000078b888b8b8b888b8b8b8b8b8b8b8b8b888b8b8b880b00000000000000000007
78bbb8bb88bbb88888bb888888b8b8bbb8b0b0bbb00b00b0b000000000007000078bbb8b8b88bb88bb8b8b8bbb8b8b8bbb8b8b88bb0bbb000000000000000007
78888888888888888888888888888888888000000000000000000000000070000788888888888888888888888888888888888888880000000000000000000007
77777777777777777777777777777777777777777777777777777777777770000777777777777777777777777777777777777777777777777777777777777777
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000

__sfx__
0004000027320153200d320063300d330013300000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00030000101700e1700c1700917005170001700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000b00000965012650046501e6001a600116000d60006600100000e00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000b00002b0202f020330201e02021020260202b0002f000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000003933038330302300000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0007000034500115500e510205501c5101b550175102855024510305502c5103b5503851000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000b000000000135501152008550075200c5500b5201655015520105500f5201d5501d5202a55029520335503352023550235203e5503f5200000000000000000000000000000000000000000000000000000000
001400000b310192200e3101422000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000200001865013620106500e6200b6500a6100965000600056000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000001b53522535325350e51000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001600002a750297101f7501e7102f7502f7102475023710000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00160000091200811015120151101f1201f1101612014110000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000003e6233e603000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
011000000124500205000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
011000000d24500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
011000001804300000180430000024615000000000000000180430000000000000002461500000000000000018043000001804300000246150000000000000001804300000000000000024615000000000000000
00600000207312d70129731227012a701277011c7011b701327012d701207010f70123701247011c701157012e7012d701367011470127701297011b701207012f70123701207012670128701277011a70123701
006000001b7312d70129701227012a701277011c7011b701327012d701207010f70123701247011c701157012e7012d701367011470127701297011b701207012f70123701207012670128701277011a70123701
00600000337312d70129701227012a701277011c7011b701327012d701207010f70123701247011c701157012e7012d701367011470127701297011b701207012f70123701207012670128701277011a70123701
006000002b7312d70126731227012a701277011c7011b701327012d701207010f70123701247011c701157012e7012d701367011470127701297011b701207012f70123701207012670128701277011a70123701
__music__
00 0a0b4344
00 55544344

