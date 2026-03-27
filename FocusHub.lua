<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width,initial-scale=1">
<meta name="theme-color" content="#ff5520">
<title>Focus Hub</title>
<link rel="icon" type="image/png" href="https://i.imgur.com/KxtzMhw.png">
<link href="https://fonts.googleapis.com/css2?family=Orbitron:wght@400;700;900&family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
<style>
/* ═══════════════════════════════════════
   FOCUS HUB v1.0 — CORE STYLES
═══════════════════════════════════════ */
:root {
  --acc:#ff5520; --acc2:#ff8c00; --adim:rgba(255,85,32,.16); --aglow:rgba(255,85,32,.35);
  --bg:#07090f; --s1:#0e1018; --s2:#141622; --s3:#1c1f2e; --s4:#242838;
  --bd:rgba(255,85,32,.2); --bd2:rgba(255,255,255,.08);
  --t1:#f2efe9; --t2:rgba(255,255,255,.68); --t3:rgba(255,255,255,.38);
  --green:#00ff88; --blue:#4a9eff; --red:#ff4455; --yellow:#ffd700;
  --sbw:240px; --sbmin:62px; --hh:58px; --r:12px; --rsm:9px; --rlg:16px;
}
*,*::before,*::after { margin:0; padding:0; box-sizing:border-box; -webkit-tap-highlight-color:transparent; }
html { font-size:15px; -webkit-text-size-adjust:100%; }
body { font-family:'Inter',-apple-system,sans-serif; background:var(--bg); color:var(--t1); width:100vw; height:100vh; overflow:hidden; }
::-webkit-scrollbar { width:5px; height:5px; }
::-webkit-scrollbar-track { background:transparent; }
::-webkit-scrollbar-thumb { background:rgba(255,85,32,.45); border-radius:3px; }

#app { display:flex; width:100vw; height:100vh; overflow:hidden; }

/* ═══════════════════════════════════════
   SIDEBAR — FIXED TOGGLE
═══════════════════════════════════════ */
#sb {
  width:var(--sbw); height:100vh; flex-shrink:0;
  background:var(--s1); border-right:1px solid var(--bd);
  display:flex; flex-direction:column; overflow:hidden;
  transition:width .28s cubic-bezier(.4,0,.2,1); z-index:50;
  position:relative;
}
#sb.col { width:var(--sbmin); }

/* Logo row — toggle button is INSIDE here, always visible */
.sb-top {
  height:var(--hh); display:flex; align-items:center;
  border-bottom:1px solid var(--bd); flex-shrink:0; overflow:hidden;
  gap:0;
}
/* Toggle button — sits on the LEFT of logo area, always visible */
.sb-tog {
  width:var(--sbmin); height:var(--hh); flex-shrink:0;
  display:flex; align-items:center; justify-content:center;
  border:none; background:none; cursor:pointer;
  transition:background .15s;
}
.sb-tog:hover { background:var(--adim); }
.sb-tog-logo {
  width:36px; height:36px; border-radius:10px; flex-shrink:0;
  overflow:hidden; display:flex; align-items:center; justify-content:center;
}
.sb-tog-logo img { width:36px; height:36px; border-radius:10px; object-fit:cover; box-shadow:0 0 14px var(--aglow); }
.sb-tog-logo .logo-fb {
  width:36px; height:36px; border-radius:10px;
  background:linear-gradient(135deg,var(--acc),var(--acc2));
  display:flex; align-items:center; justify-content:center;
  font-family:'Orbitron',sans-serif; font-weight:900; font-size:18px; color:#fff;
  box-shadow:0 0 14px var(--aglow);
}
/* Arrow indicator */
.sb-tog-arrow {
  position:absolute; right:0; top:50%; transform:translateY(-50%);
  width:18px; height:18px; display:flex; align-items:center; justify-content:center;
  font-size:11px; color:var(--t3); pointer-events:none;
  transition:transform .28s, opacity .2s;
}
#sb.col .sb-tog-arrow { transform:translateY(-50%) rotate(180deg); }

/* Logo text — hidden when collapsed */
.sb-info {
  flex:1; overflow:hidden; padding:0 4px 0 2px;
  transition:opacity .2s; min-width:0;
}
.sb-info-t { font-family:'Orbitron',sans-serif; font-size:13px; font-weight:900; white-space:nowrap; background:linear-gradient(135deg,var(--acc),var(--acc2)); -webkit-background-clip:text; -webkit-text-fill-color:transparent; }
.sb-info-s { font-size:10px; color:var(--t3); white-space:nowrap; margin-top:1px; }
#sb.col .sb-info { opacity:0; width:0; padding:0; }

/* Nav */
.sb-nav { flex:1; overflow-y:auto; overflow-x:hidden; padding:10px 8px; display:flex; flex-direction:column; gap:2px; -webkit-overflow-scrolling:touch; }
.sb-sec { font-size:9px; font-weight:700; text-transform:uppercase; letter-spacing:1.5px; color:var(--t3); padding:10px 8px 3px; white-space:nowrap; flex-shrink:0; }
#sb.col .sb-sec { display:none; }

.sbtn {
  display:flex; align-items:center; gap:10px; padding:10px 11px;
  border-radius:var(--rsm); border:none; background:none;
  color:var(--t2); font-family:'Inter',sans-serif; font-size:13px; font-weight:500;
  cursor:pointer; width:100%; text-align:left; white-space:nowrap;
  overflow:hidden; flex-shrink:0; transition:background .15s,color .15s; position:relative;
}
.sbtn:hover { background:var(--adim); color:var(--t1); }
.sbtn.act { background:var(--adim); color:var(--acc); font-weight:600; }
.sbtn.act::before { content:''; position:absolute; left:0; top:20%; bottom:20%; width:3px; border-radius:0 3px 3px 0; background:var(--acc); }
.sbtn-ico { font-size:18px; width:24px; text-align:center; flex-shrink:0; }
.sbtn-lbl { flex:1; overflow:hidden; text-overflow:ellipsis; }
.sbtn-cnt { background:var(--acc); color:#fff; font-size:9px; font-weight:700; padding:1px 6px; border-radius:10px; flex-shrink:0; }
#sb.col .sbtn-lbl, #sb.col .sbtn-cnt { display:none; }

/* Mobile overlay */
#sb-ov { display:none; position:fixed; inset:0; background:rgba(0,0,0,.65); z-index:49; backdrop-filter:blur(3px); }

/* ═══════════════════════════════════════
   MAIN
═══════════════════════════════════════ */
#main { flex:1; min-width:0; height:100vh; display:flex; flex-direction:column; overflow:hidden; }

/* Page header */
.ph {
  height:var(--hh); flex-shrink:0; display:flex; align-items:center; gap:12px;
  padding:0 22px; background:rgba(14,16,24,.97); border-bottom:1px solid var(--bd);
  backdrop-filter:blur(12px); -webkit-backdrop-filter:blur(12px); z-index:10;
}
.ph-hbg { width:36px; height:36px; border:none; background:var(--s3); border-radius:var(--rsm); color:var(--t2); font-size:18px; cursor:pointer; display:none; align-items:center; justify-content:center; flex-shrink:0; }
.ph-logo img { width:28px; height:28px; border-radius:7px; object-fit:cover; flex-shrink:0; display:block; }
.ph-logo .logo-fb { width:28px; height:28px; border-radius:7px; background:linear-gradient(135deg,var(--acc),var(--acc2)); display:flex; align-items:center; justify-content:center; font-family:'Orbitron',sans-serif; font-weight:900; font-size:13px; color:#fff; }
.ph-logo { display:none; }
.ph-titles { display:flex; flex-direction:column; justify-content:center; }
.ph-h1 { font-family:'Orbitron',sans-serif; font-size:15px; font-weight:700; white-space:nowrap; line-height:1.2; }
.ph-sub { font-size:10px; color:var(--t3); white-space:nowrap; }
.ph-sp { flex:1; }
.ph-bv { padding:4px 12px; border-radius:20px; font-size:10px; font-weight:700; background:var(--s3); border:1px solid var(--bd); color:var(--t2); white-space:nowrap; }
.ph-bd { padding:5px 14px; border-radius:20px; font-size:10px; font-weight:700; background:linear-gradient(135deg,#5865f2,#7289da); color:#fff; white-space:nowrap; text-decoration:none; display:inline-flex; align-items:center; gap:4px; }
.ph-bc { padding:5px 14px; border-radius:20px; font-size:10px; font-weight:700; background:linear-gradient(135deg,var(--acc),var(--acc2)); color:#fff; white-space:nowrap; }

/* Page content */
.pc { flex:1; overflow-y:auto; overflow-x:hidden; padding:22px; -webkit-overflow-scrolling:touch; }

/* Pages */
.pg { display:none; flex-direction:column; height:100vh; }
.pg.on { display:flex; }

/* ═══════════════════════════════════════
   TOOL & GAME GRIDS
═══════════════════════════════════════ */
.tgrid { display:grid; grid-template-columns:repeat(auto-fill,minmax(148px,1fr)); gap:12px; }
.ggrid { display:grid; grid-template-columns:repeat(auto-fill,minmax(165px,1fr)); gap:14px; }

.tc { background:var(--s2); border:1px solid var(--bd2); border-radius:var(--r); padding:18px 12px; cursor:pointer; text-align:center; transition:all .2s cubic-bezier(.4,0,.2,1); display:flex; flex-direction:column; align-items:center; gap:7px; user-select:none; }
.tc:hover { background:var(--s3); border-color:var(--acc); transform:translateY(-3px); box-shadow:0 8px 24px rgba(255,85,32,.15); }
.tc:active { transform:scale(.97); }
.tc-i { font-size:28px; line-height:1; }
.tc-n { font-size:12px; font-weight:600; color:var(--t1); line-height:1.3; }
.tc-c { font-size:10px; color:var(--t3); }

.gc { background:var(--s2); border:1px solid var(--bd2); border-radius:var(--r); padding:20px 12px; cursor:pointer; text-align:center; transition:all .2s; display:flex; flex-direction:column; align-items:center; gap:6px; user-select:none; }
.gc:hover { background:var(--s3); border-color:var(--acc); transform:translateY(-3px); box-shadow:0 8px 24px rgba(255,85,32,.2); }
.gc:active { transform:scale(.97); }
.gc-i { font-size:34px; line-height:1; }
.gc-n { font-family:'Orbitron',sans-serif; font-size:10px; font-weight:700; color:var(--t1); line-height:1.3; }
.gc-d { font-size:10px; color:var(--t3); }
.gc-p { margin-top:4px; padding:5px 16px; border-radius:20px; font-size:9px; font-weight:700; background:linear-gradient(135deg,var(--acc),var(--acc2)); color:#fff; }

.sh { font-family:'Orbitron',sans-serif; font-size:11px; font-weight:700; color:var(--acc); margin:22px 0 12px; display:flex; align-items:center; gap:8px; }
.sh:first-child { margin-top:0; }
.sh::after { content:''; flex:1; height:1px; background:var(--bd); }

/* ═══════════════════════════════════════
   HOME PAGE
═══════════════════════════════════════ */
.hero { background:linear-gradient(135deg,rgba(255,85,32,.12),rgba(255,140,0,.06),transparent); border:1px solid var(--bd); border-radius:var(--rlg); padding:28px; margin-bottom:18px; position:relative; overflow:hidden; }
.hero::before { content:''; position:absolute; top:-50%; right:-10%; width:320px; height:320px; background:radial-gradient(circle,rgba(255,85,32,.1),transparent 70%); pointer-events:none; }
.hero-in { display:flex; align-items:center; gap:22px; position:relative; flex-wrap:wrap; }
.hero-img img { width:80px; height:80px; border-radius:18px; object-fit:cover; box-shadow:0 0 32px var(--aglow); flex-shrink:0; }
.hero-img .logo-fb { width:80px; height:80px; border-radius:18px; background:linear-gradient(135deg,var(--acc),var(--acc2)); display:flex; align-items:center; justify-content:center; font-family:'Orbitron',sans-serif; font-weight:900; font-size:36px; color:#fff; box-shadow:0 0 32px var(--aglow); flex-shrink:0; }
.hero-t h2 { font-family:'Orbitron',sans-serif; font-size:clamp(18px,2.8vw,28px); font-weight:900; background:linear-gradient(135deg,var(--acc),var(--acc2),#fff); -webkit-background-clip:text; -webkit-text-fill-color:transparent; margin-bottom:8px; line-height:1.2; }
.hero-t p { font-size:13px; color:var(--t2); line-height:1.6; margin-bottom:18px; max-width:480px; }
.hstats { display:flex; gap:24px; flex-wrap:wrap; }
.hstat .hv { font-family:'Orbitron',sans-serif; font-size:28px; font-weight:900; color:var(--acc); line-height:1; }
.hstat .hl { font-size:10px; font-weight:700; color:var(--t3); text-transform:uppercase; letter-spacing:.5px; margin-top:3px; }

/* Discord Banner */
.dban { background:linear-gradient(135deg,rgba(88,101,242,.14),rgba(88,101,242,.05)); border:1px solid rgba(88,101,242,.32); border-radius:var(--r); padding:18px 22px; margin-bottom:18px; display:flex; align-items:center; gap:16px; flex-wrap:wrap; }
.dban-i { font-size:32px; flex-shrink:0; }
.dban-t { flex:1; min-width:180px; }
.dban-t h3 { font-size:15px; font-weight:700; color:#7289da; margin-bottom:4px; }
.dban-t p { font-size:12px; color:var(--t3); }
.dban-btn { padding:11px 24px; background:linear-gradient(135deg,#5865f2,#7289da); color:#fff; border:none; border-radius:var(--rsm); font-family:'Inter',sans-serif; font-size:13px; font-weight:700; cursor:pointer; white-space:nowrap; text-decoration:none; display:inline-block; transition:all .15s; }
.dban-btn:hover { transform:translateY(-1px); box-shadow:0 4px 18px rgba(88,101,242,.45); }

/* Category info grid */
.igrid { display:grid; grid-template-columns:repeat(auto-fill,minmax(195px,1fr)); gap:12px; margin-bottom:18px; }
.icard { background:var(--s2); border:1px solid var(--bd2); border-radius:var(--r); padding:16px; transition:border-color .2s,transform .2s; cursor:default; }
.icard:hover { border-color:rgba(255,85,32,.35); transform:translateY(-2px); }
.icard-i { font-size:22px; margin-bottom:8px; }
.icard-t { font-family:'Orbitron',sans-serif; font-size:10px; font-weight:700; color:var(--acc2); margin-bottom:5px; }
.icard-d { font-size:11px; color:var(--t3); line-height:1.5; }

/* News */
.nbox { background:var(--s2); border:1px solid var(--bd2); border-radius:var(--r); padding:18px 20px; }
.nbox-t { font-family:'Orbitron',sans-serif; font-size:11px; font-weight:700; color:var(--acc); margin-bottom:14px; }
.ni { display:flex; gap:10px; align-items:flex-start; padding:9px 0; border-bottom:1px solid var(--bd2); }
.ni:last-child { border:none; padding-bottom:0; }
.ndot { width:7px; height:7px; border-radius:50%; background:var(--acc); flex-shrink:0; margin-top:5px; }
.ntxt { font-size:12px; line-height:1.5; }
.ndate { font-size:9px; color:var(--t3); margin-top:2px; }

/* ═══════════════════════════════════════
   MODAL
═══════════════════════════════════════ */
#mod-ov { position:fixed; inset:0; background:rgba(7,9,15,.9); backdrop-filter:blur(16px); -webkit-backdrop-filter:blur(16px); z-index:200; display:none; align-items:center; justify-content:center; padding:12px; }
#mod-ov.on { display:flex; }
#mod-box { background:var(--s1); border:1px solid var(--bd); border-radius:var(--rlg); width:min(590px,100%); max-height:92vh; display:flex; flex-direction:column; overflow:hidden; animation:mop .2s cubic-bezier(.4,0,.2,1); box-shadow:0 24px 64px rgba(0,0,0,.7); }
@keyframes mop { from{opacity:0;transform:scale(.93) translateY(10px)} to{opacity:1;transform:scale(1) translateY(0)} }
.mhd { display:flex; align-items:center; gap:10px; padding:16px 18px; border-bottom:1px solid var(--bd); flex-shrink:0; }
.mhd-i { font-size:20px; flex-shrink:0; }
.mhd-t { font-family:'Orbitron',sans-serif; font-size:13px; font-weight:700; flex:1; }
.mcls { width:30px; height:30px; border-radius:7px; border:none; background:var(--s3); color:var(--t3); font-size:15px; cursor:pointer; display:flex; align-items:center; justify-content:center; transition:all .15s; flex-shrink:0; }
.mcls:hover { background:rgba(255,68,85,.2); color:var(--red); }
.mbody { padding:18px; overflow-y:auto; flex:1; -webkit-overflow-scrolling:touch; }

/* Form elements */
.fg { display:flex; flex-direction:column; gap:4px; margin-bottom:12px; }
.fl { font-size:10px; font-weight:700; text-transform:uppercase; letter-spacing:1px; color:var(--t3); }
.fi,.fta,.fsel { width:100%; padding:9px 12px; background:var(--s3); border:1px solid var(--bd2); border-radius:var(--rsm); color:var(--t1); font-family:'Inter',sans-serif; font-size:13px; outline:none; transition:border-color .15s; -webkit-appearance:none; }
.fi:focus,.fta:focus,.fsel:focus { border-color:var(--acc); }
.fta { resize:vertical; min-height:80px; }
.fi.mono,.fta.mono { font-family:'Courier New',Courier,monospace; font-size:12px; }
.fr { display:flex; gap:8px; flex-wrap:wrap; align-items:flex-end; }
.fr .fi,.fr .fsel { flex:1; min-width:60px; }
.fhint { font-size:10px; color:var(--t3); line-height:1.4; margin-top:3px; }
.fdiv { border:none; border-top:1px solid var(--bd2); margin:14px 0; }

.btn { padding:9px 18px; border-radius:var(--rsm); border:none; cursor:pointer; font-family:'Inter',sans-serif; font-size:13px; font-weight:600; transition:all .15s; white-space:nowrap; display:inline-block; }
.btn:active { transform:scale(.97); }
.btn-p { background:linear-gradient(135deg,var(--acc),var(--acc2)); color:#fff; box-shadow:0 2px 10px rgba(255,85,32,.25); }
.btn-p:hover { box-shadow:0 4px 18px rgba(255,85,32,.4); transform:translateY(-1px); }
.btn-s { background:var(--s3); color:var(--t2); border:1px solid var(--bd2); }
.btn-s:hover { background:var(--s4); color:var(--t1); }
.btn-sm { padding:6px 12px; font-size:11px; }
.bg { display:flex; gap:7px; flex-wrap:wrap; margin:8px 0; }

.out { background:var(--s3); border:1px solid var(--bd2); border-radius:var(--rsm); padding:10px 12px; font-size:13px; font-weight:600; color:var(--acc2); white-space:pre-wrap; word-break:break-all; line-height:1.6; min-height:36px; }
.out.mono { font-family:'Courier New',Courier,monospace; font-size:11px; }
.out.big { font-family:'Orbitron',sans-serif; font-size:28px; text-align:center; color:var(--acc); }
.cpre { background:var(--s3); border:1px solid var(--bd2); border-radius:var(--rsm); padding:10px 12px; font-family:'Courier New',Courier,monospace; font-size:11px; line-height:1.6; overflow-x:auto; white-space:pre; max-height:200px; overflow-y:auto; -webkit-overflow-scrolling:touch; }

/* ═══════════════════════════════════════
   GAME OVERLAY
═══════════════════════════════════════ */
#gmod { position:fixed; inset:0; background:rgba(7,9,15,.97); backdrop-filter:blur(20px); -webkit-backdrop-filter:blur(20px); z-index:300; display:none; flex-direction:column; align-items:center; justify-content:flex-start; padding:12px; overflow-y:auto; -webkit-overflow-scrolling:touch; }
#gmod.on { display:flex; }
.ghd { display:flex; align-items:center; gap:10px; width:100%; max-width:540px; margin-bottom:8px; flex-shrink:0; }
.g-ico { font-size:22px; }
.g-ttl { font-family:'Orbitron',sans-serif; font-size:16px; font-weight:700; flex:1; }
.gcls { width:34px; height:34px; border-radius:8px; border:none; background:var(--s3); color:var(--t3); font-size:16px; cursor:pointer; display:flex; align-items:center; justify-content:center; transition:all .15s; }
.gcls:hover { background:rgba(255,68,85,.2); color:var(--red); }
#gsc { font-family:'Orbitron',sans-serif; font-size:18px; font-weight:700; color:var(--acc); margin-bottom:8px; text-align:center; min-height:24px; flex-shrink:0; }
#gcv { border-radius:12px; border:1px solid var(--bd); display:block; touch-action:none; flex-shrink:0; max-width:100%; }
#gdom { width:100%; max-width:540px; flex-shrink:0; }
#gov { display:none; text-align:center; padding:10px; flex-shrink:0; }
#govt { font-family:'Orbitron',sans-serif; font-size:22px; font-weight:900; margin-bottom:5px; }
#govs { font-size:13px; color:var(--t2); }
#gbtns { display:flex; gap:10px; flex-wrap:wrap; justify-content:center; margin-top:12px; flex-shrink:0; }
.gbtn { padding:11px 26px; border-radius:10px; border:none; cursor:pointer; font-family:'Orbitron',sans-serif; font-size:11px; font-weight:700; transition:all .15s; }
.gbtn:active { transform:scale(.96); }
.gbtn-s { background:linear-gradient(135deg,var(--acc),var(--acc2)); color:#fff; }
.gbtn-s:hover { box-shadow:0 4px 18px var(--aglow); transform:translateY(-1px); }
.gbtn-r { background:linear-gradient(135deg,var(--acc),var(--acc2)); color:#fff; display:none; }
.gbtn-c { background:var(--s3); color:var(--t2); }

/* ═══════════════════════════════════════
   RESPONSIVE
═══════════════════════════════════════ */
@media (max-width:768px) {
  #sb { position:fixed; left:0; top:0; height:100vh; z-index:100; transform:translateX(-100%); width:270px !important; transition:transform .25s cubic-bezier(.4,0,.2,1); }
  #sb.mob-open { transform:translateX(0); }
  #sb-ov.on { display:block; }
  #sb .sb-info { opacity:1 !important; width:auto !important; padding:0 4px 0 2px !important; }
  #sb .sbtn-lbl { display:block !important; }
  #sb .sbtn-cnt { display:inline-block !important; }
  #sb .sb-sec { display:block !important; }
  .sb-tog-arrow { display:none !important; }
  .ph-hbg { display:flex !important; }
  .ph-logo { display:block !important; }
  .pc { padding:12px; }
  .tgrid { grid-template-columns:repeat(auto-fill,minmax(130px,1fr)); gap:9px; }
  .ggrid { grid-template-columns:repeat(auto-fill,minmax(145px,1fr)); gap:10px; }
  .igrid { grid-template-columns:repeat(auto-fill,minmax(165px,1fr)); }
  #mod-box { max-height:95vh; }
  .mbody { padding:14px; }
  .hero-img img, .hero-img .logo-fb { width:60px; height:60px; font-size:28px; border-radius:14px; }
}
@media (max-width:420px) {
  .tgrid { grid-template-columns:repeat(2,1fr); gap:8px; }
  .ggrid { grid-template-columns:repeat(2,1fr); gap:9px; }
  .tc { padding:14px 8px; }
  .tc-i { font-size:24px; }
  .gc { padding:16px 8px; }
  .gc-i { font-size:28px; }
}
@media (min-width:1400px) {
  .tgrid { grid-template-columns:repeat(auto-fill,minmax(162px,1fr)); }
  .ggrid { grid-template-columns:repeat(auto-fill,minmax(178px,1fr)); }
  .igrid { grid-template-columns:repeat(auto-fill,minmax(215px,1fr)); }
}
</style>
</head>
<body>
<div id="app">

<!-- ════════════════ SIDEBAR ════════════════ -->
<nav id="sb">
  <!-- Toggle button is the FULL top area — click anywhere to toggle -->
  <div class="sb-top">
    <button class="sb-tog" onclick="toggleSB()" title="Toggle sidebar">
      <div class="sb-tog-logo">
        <img id="logo-img" src="https://i.imgur.com/KxtzMhw.png" onerror="this.style.display='none';document.getElementById('logo-fb-sb').style.display='flex'" alt="FH">
        <div class="logo-fb" id="logo-fb-sb" style="display:none">F</div>
      </div>
      <div class="sb-tog-arrow" id="sb-arrow">▶</div>
    </button>
    <div class="sb-info">
      <div class="sb-info-t">FOCUS HUB</div>
      <div class="sb-info-s">v1.0 — by Zaeem</div>
    </div>
  </div>

  <div class="sb-nav">
    <div class="sb-sec">MAIN</div>
    <button class="sbtn act" onclick="goPage('home',this)"><span class="sbtn-ico">🏠</span><span class="sbtn-lbl">Home</span></button>

    <div class="sb-sec">UTILITIES</div>
    <button class="sbtn" onclick="goPage('math',this)"><span class="sbtn-ico">🔢</span><span class="sbtn-lbl">Math &amp; Numbers</span><span class="sbtn-cnt">20</span></button>
    <button class="sbtn" onclick="goPage('text',this)"><span class="sbtn-ico">📝</span><span class="sbtn-lbl">Text Tools</span><span class="sbtn-cnt">20</span></button>
    <button class="sbtn" onclick="goPage('convert',this)"><span class="sbtn-ico">🔄</span><span class="sbtn-lbl">Converters</span><span class="sbtn-cnt">20</span></button>
    <button class="sbtn" onclick="goPage('gen',this)"><span class="sbtn-ico">⚡</span><span class="sbtn-lbl">Generators</span><span class="sbtn-cnt">20</span></button>
    <button class="sbtn" onclick="goPage('time',this)"><span class="sbtn-ico">⏱</span><span class="sbtn-lbl">Time &amp; Productivity</span><span class="sbtn-cnt">15</span></button>
    <button class="sbtn" onclick="goPage('encode',this)"><span class="sbtn-ico">🔐</span><span class="sbtn-lbl">Encode &amp; Crypto</span><span class="sbtn-cnt">15</span></button>
    <button class="sbtn" onclick="goPage('health',this)"><span class="sbtn-ico">💪</span><span class="sbtn-lbl">Health &amp; Fitness</span><span class="sbtn-cnt">15</span></button>
    <button class="sbtn" onclick="goPage('finance',this)"><span class="sbtn-ico">💰</span><span class="sbtn-lbl">Finance</span><span class="sbtn-cnt">15</span></button>
    <button class="sbtn" onclick="goPage('science',this)"><span class="sbtn-ico">🔬</span><span class="sbtn-lbl">Science &amp; Physics</span><span class="sbtn-cnt">15</span></button>

    <div class="sb-sec">DEVELOPER</div>
    <button class="sbtn" onclick="goPage('code',this)"><span class="sbtn-ico">💻</span><span class="sbtn-lbl">Coding Tools</span><span class="sbtn-cnt">20</span></button>
    <button class="sbtn" onclick="goPage('design',this)"><span class="sbtn-ico">🎨</span><span class="sbtn-lbl">Design Tools</span><span class="sbtn-cnt">15</span></button>
    <button class="sbtn" onclick="goPage('files',this)"><span class="sbtn-ico">📁</span><span class="sbtn-lbl">File Tools</span><span class="sbtn-cnt">15</span></button>

    <div class="sb-sec">COMMUNITY</div>
    <button class="sbtn" onclick="goPage('discord',this)"><span class="sbtn-ico">💬</span><span class="sbtn-lbl">Discord Tools</span><span class="sbtn-cnt">15</span></button>
    <button class="sbtn" onclick="goPage('roblox',this)"><span class="sbtn-ico">🎮</span><span class="sbtn-lbl">Roblox Tools</span><span class="sbtn-cnt">15</span></button>

    <div class="sb-sec">GAMES</div>
    <button class="sbtn" onclick="goPage('games',this)"><span class="sbtn-ico">🕹️</span><span class="sbtn-lbl">Games</span><span class="sbtn-cnt">100</span></button>
  </div>
</nav>
<div id="sb-ov" onclick="closeMobSB()"></div>

<!-- ════════════════ MAIN ════════════════ -->
<div id="main">

<!-- HOME -->
<div class="pg on" id="pg-home">
  <div class="ph">
    <button class="ph-hbg" onclick="openMobSB()">☰</button>
    <div class="ph-logo">
      <img src="https://i.imgur.com/KxtzMhw.png" onerror="this.style.display='none';document.getElementById('ph-fb').style.display='flex'" alt="">
      <div class="logo-fb" id="ph-fb" style="display:none">F</div>
    </div>
    <div class="ph-titles">
      <div class="ph-h1">Focus Hub</div>
      <div class="ph-sub">All-in-one toolkit by Zaeem</div>
    </div>
    <div class="ph-sp"></div>
    <span class="ph-bv">v1.0</span>
    <a href="https://discord.gg/n6FE92EDVU" target="_blank" class="ph-bd">💬 Discord</a>
  </div>
  <div class="pc">
    <div class="hero">
      <div class="hero-in">
        <div class="hero-img">
          <img src="https://i.imgur.com/KxtzMhw.png" onerror="this.style.display='none';document.getElementById('hero-fb').style.display='flex'" alt="Focus Hub">
          <div class="logo-fb" id="hero-fb" style="display:none">F</div>
        </div>
        <div class="hero-t">
          <h2>Welcome to Focus Hub</h2>
          <p>The most powerful browser toolkit ever built. 250+ utilities, 100 games, Discord tools, Roblox tools — 100% free, no login, works on every device.</p>
          <div class="hstats">
            <div class="hstat"><div class="hv">250+</div><div class="hl">Utilities</div></div>
            <div class="hstat"><div class="hv">100</div><div class="hl">Games</div></div>
            <div class="hstat"><div class="hv">14</div><div class="hl">Categories</div></div>
            <div class="hstat"><div class="hv">Free</div><div class="hl">Forever</div></div>
          </div>
        </div>
      </div>
    </div>

    <div class="dban">
      <div class="dban-i">💬</div>
      <div class="dban-t">
        <h3>Join the Focus Hub Discord Server</h3>
        <p>Get updates, suggest features, and connect with the community — discord.gg/n6FE92EDVU</p>
      </div>
      <a href="https://discord.gg/n6FE92EDVU" target="_blank" class="dban-btn">Join Server →</a>
    </div>

    <div class="sh">📦 All Categories</div>
    <div class="igrid">
      <div class="icard"><div class="icard-i">🔢</div><div class="icard-t">Math &amp; Numbers</div><div class="icard-d">Calculator, BMI, prime checker, Fibonacci, loan, geometry and more</div></div>
      <div class="icard"><div class="icard-i">📝</div><div class="icard-t">Text Tools</div><div class="icard-d">Word counter, case converter, diff checker, to-do list and more</div></div>
      <div class="icard"><div class="icard-i">🔄</div><div class="icard-t">Converters</div><div class="icard-d">Temperature, length, weight, speed, currency, data size and more</div></div>
      <div class="icard"><div class="icard-i">⚡</div><div class="icard-t">Generators</div><div class="icard-d">Password, UUID, Lorem Ipsum, color palette, QR code and more</div></div>
      <div class="icard"><div class="icard-i">⏱</div><div class="icard-t">Time &amp; Productivity</div><div class="icard-d">Stopwatch, Pomodoro, habit tracker, world clock, alarm and more</div></div>
      <div class="icard"><div class="icard-i">🔐</div><div class="icard-t">Encode &amp; Crypto</div><div class="icard-d">Base64, binary, Morse code, Caesar cipher, ROT13 and more</div></div>
      <div class="icard"><div class="icard-i">💪</div><div class="icard-t">Health &amp; Fitness</div><div class="icard-d">TDEE, heart rate zones, macros, BMI, sleep calculator and more</div></div>
      <div class="icard"><div class="icard-i">💰</div><div class="icard-t">Finance</div><div class="icard-d">Compound interest, mortgage, tax, salary, ROI and more</div></div>
      <div class="icard"><div class="icard-i">🔬</div><div class="icard-t">Science &amp; Physics</div><div class="icard-d">Ohm's law, kinematics, periodic table, unit analysis and more</div></div>
      <div class="icard"><div class="icard-i">💻</div><div class="icard-t">Coding Tools</div><div class="icard-d">JSON formatter, regex tester, JWT decoder, diff checker and more</div></div>
      <div class="icard"><div class="icard-i">🎨</div><div class="icard-t">Design Tools</div><div class="icard-d">Color picker, gradient maker, shadow generator, contrast and more</div></div>
      <div class="icard"><div class="icard-i">📁</div><div class="icard-t">File Tools</div><div class="icard-d">Text reader, CSV viewer, image info, file compressor and more</div></div>
      <div class="icard"><div class="icard-i">💬</div><div class="icard-t">Discord Tools</div><div class="icard-d">Timestamp gen, embed builder, role picker, snowflake decoder</div></div>
      <div class="icard"><div class="icard-i">🎮</div><div class="icard-t">Roblox Tools</div><div class="icard-d">BrickColor, CFrame helper, Lua formatter, API snippets and more</div></div>
      <div class="icard"><div class="icard-i">🕹️</div><div class="icard-t">100 Games</div><div class="icard-d">Snake, 2048, Breakout, Flappy Bird, Wordle, Chess and 94 more</div></div>
    </div>

    <div class="sh">📡 Release Notes</div>
    <div class="nbox">
      <div class="nbox-t">🚀 FOCUS HUB v1.0 — OFFICIAL RELEASE</div>
      <div class="ni"><div class="ndot"></div><div><div class="ntxt">🚀 v1.0 Launch — 250+ utilities and 100 games all working with no errors</div><div class="ndate">v1.0</div></div></div>
      <div class="ni"><div class="ndot"></div><div><div class="ntxt">💬 Discord Tools — timestamps, embed builder, role colors, snowflake decoder</div><div class="ndate">v1.0</div></div></div>
      <div class="ni"><div class="ndot"></div><div><div class="ntxt">🎮 Roblox Tools — BrickColor, CFrame, Lua formatter, API snippets, constants</div><div class="ndate">v1.0</div></div></div>
      <div class="ni"><div class="ndot"></div><div><div class="ntxt">🔬 New: Science &amp; Physics — Ohm's law, kinematics, periodic table and more</div><div class="ndate">v1.0</div></div></div>
      <div class="ni"><div class="ndot"></div><div><div class="ntxt">🕹️ 100 working games — every game has ▶ START and 🔁 RETRY buttons</div><div class="ndate">v1.0</div></div></div>
      <div class="ni"><div class="ndot"></div><div><div class="ntxt">📱 Full mobile + tablet + desktop — all devices fully supported</div><div class="ndate">v1.0</div></div></div>
      <div class="ni"><div class="ndot"></div><div><div class="ntxt">🆓 100% free forever — no ads, no accounts, no tracking, no limits</div><div class="ndate">Always</div></div></div>
    </div>
  </div>
</div>

<!-- ALL SECTION PAGES -->
<div class="pg" id="pg-math">   <div class="ph"><button class="ph-hbg" onclick="openMobSB()">☰</button><div class="ph-logo"><img src="https://i.imgur.com/KxtzMhw.png" onerror="this.style.display='none'" alt=""><div class="logo-fb" style="display:none">F</div></div><div class="ph-titles"><div class="ph-h1">Math &amp; Numbers</div><div class="ph-sub">20 calculation tools</div></div><div class="ph-sp"></div><span class="ph-bc">20 Tools</span></div><div class="pc"><div class="tgrid" id="g-math"></div></div></div>
<div class="pg" id="pg-text">   <div class="ph"><button class="ph-hbg" onclick="openMobSB()">☰</button><div class="ph-logo"><img src="https://i.imgur.com/KxtzMhw.png" onerror="this.style.display='none'" alt=""><div class="logo-fb" style="display:none">F</div></div><div class="ph-titles"><div class="ph-h1">Text Tools</div><div class="ph-sub">20 text utilities</div></div><div class="ph-sp"></div><span class="ph-bc">20 Tools</span></div><div class="pc"><div class="tgrid" id="g-text"></div></div></div>
<div class="pg" id="pg-convert"><div class="ph"><button class="ph-hbg" onclick="openMobSB()">☰</button><div class="ph-logo"><img src="https://i.imgur.com/KxtzMhw.png" onerror="this.style.display='none'" alt=""><div class="logo-fb" style="display:none">F</div></div><div class="ph-titles"><div class="ph-h1">Converters</div><div class="ph-sub">20 unit converters</div></div><div class="ph-sp"></div><span class="ph-bc">20 Tools</span></div><div class="pc"><div class="tgrid" id="g-convert"></div></div></div>
<div class="pg" id="pg-gen">    <div class="ph"><button class="ph-hbg" onclick="openMobSB()">☰</button><div class="ph-logo"><img src="https://i.imgur.com/KxtzMhw.png" onerror="this.style.display='none'" alt=""><div class="logo-fb" style="display:none">F</div></div><div class="ph-titles"><div class="ph-h1">Generators</div><div class="ph-sub">20 generators</div></div><div class="ph-sp"></div><span class="ph-bc">20 Tools</span></div><div class="pc"><div class="tgrid" id="g-gen"></div></div></div>
<div class="pg" id="pg-time">   <div class="ph"><button class="ph-hbg" onclick="openMobSB()">☰</button><div class="ph-logo"><img src="https://i.imgur.com/KxtzMhw.png" onerror="this.style.display='none'" alt=""><div class="logo-fb" style="display:none">F</div></div><div class="ph-titles"><div class="ph-h1">Time &amp; Productivity</div><div class="ph-sub">15 productivity tools</div></div><div class="ph-sp"></div><span class="ph-bc">15 Tools</span></div><div class="pc"><div class="tgrid" id="g-time"></div></div></div>
<div class="pg" id="pg-encode"> <div class="ph"><button class="ph-hbg" onclick="openMobSB()">☰</button><div class="ph-logo"><img src="https://i.imgur.com/KxtzMhw.png" onerror="this.style.display='none'" alt=""><div class="logo-fb" style="display:none">F</div></div><div class="ph-titles"><div class="ph-h1">Encode &amp; Crypto</div><div class="ph-sub">15 encoding tools</div></div><div class="ph-sp"></div><span class="ph-bc">15 Tools</span></div><div class="pc"><div class="tgrid" id="g-encode"></div></div></div>
<div class="pg" id="pg-health"> <div class="ph"><button class="ph-hbg" onclick="openMobSB()">☰</button><div class="ph-logo"><img src="https://i.imgur.com/KxtzMhw.png" onerror="this.style.display='none'" alt=""><div class="logo-fb" style="display:none">F</div></div><div class="ph-titles"><div class="ph-h1">Health &amp; Fitness</div><div class="ph-sub">15 health tools</div></div><div class="ph-sp"></div><span class="ph-bc">15 Tools</span></div><div class="pc"><div class="tgrid" id="g-health"></div></div></div>
<div class="pg" id="pg-finance"><div class="ph"><button class="ph-hbg" onclick="openMobSB()">☰</button><div class="ph-logo"><img src="https://i.imgur.com/KxtzMhw.png" onerror="this.style.display='none'" alt=""><div class="logo-fb" style="display:none">F</div></div><div class="ph-titles"><div class="ph-h1">Finance</div><div class="ph-sub">15 financial tools</div></div><div class="ph-sp"></div><span class="ph-bc">15 Tools</span></div><div class="pc"><div class="tgrid" id="g-finance"></div></div></div>
<div class="pg" id="pg-science"><div class="ph"><button class="ph-hbg" onclick="openMobSB()">☰</button><div class="ph-logo"><img src="https://i.imgur.com/KxtzMhw.png" onerror="this.style.display='none'" alt=""><div class="logo-fb" style="display:none">F</div></div><div class="ph-titles"><div class="ph-h1">Science &amp; Physics</div><div class="ph-sub">15 science tools</div></div><div class="ph-sp"></div><span class="ph-bc">15 Tools</span></div><div class="pc"><div class="tgrid" id="g-science"></div></div></div>
<div class="pg" id="pg-code">   <div class="ph"><button class="ph-hbg" onclick="openMobSB()">☰</button><div class="ph-logo"><img src="https://i.imgur.com/KxtzMhw.png" onerror="this.style.display='none'" alt=""><div class="logo-fb" style="display:none">F</div></div><div class="ph-titles"><div class="ph-h1">Coding Tools</div><div class="ph-sub">20 developer tools</div></div><div class="ph-sp"></div><span class="ph-bc">20 Tools</span></div><div class="pc"><div class="tgrid" id="g-code"></div></div></div>
<div class="pg" id="pg-design"> <div class="ph"><button class="ph-hbg" onclick="openMobSB()">☰</button><div class="ph-logo"><img src="https://i.imgur.com/KxtzMhw.png" onerror="this.style.display='none'" alt=""><div class="logo-fb" style="display:none">F</div></div><div class="ph-titles"><div class="ph-h1">Design Tools</div><div class="ph-sub">15 design tools</div></div><div class="ph-sp"></div><span class="ph-bc">15 Tools</span></div><div class="pc"><div class="tgrid" id="g-design"></div></div></div>
<div class="pg" id="pg-files">  <div class="ph"><button class="ph-hbg" onclick="openMobSB()">☰</button><div class="ph-logo"><img src="https://i.imgur.com/KxtzMhw.png" onerror="this.style.display='none'" alt=""><div class="logo-fb" style="display:none">F</div></div><div class="ph-titles"><div class="ph-h1">File Tools</div><div class="ph-sub">15 file utilities</div></div><div class="ph-sp"></div><span class="ph-bc">15 Tools</span></div><div class="pc"><div class="tgrid" id="g-files"></div></div></div>
<div class="pg" id="pg-discord"><div class="ph"><button class="ph-hbg" onclick="openMobSB()">☰</button><div class="ph-logo"><img src="https://i.imgur.com/KxtzMhw.png" onerror="this.style.display='none'" alt=""><div class="logo-fb" style="display:none">F</div></div><div class="ph-titles"><div class="ph-h1">Discord Tools</div><div class="ph-sub">15 Discord utilities</div></div><div class="ph-sp"></div><span class="ph-bd" style="padding:5px 14px;border-radius:20px;font-size:10px;font-weight:700;background:linear-gradient(135deg,#5865f2,#7289da);color:#fff;white-space:nowrap;">15 Tools</span></div><div class="pc"><div class="tgrid" id="g-discord"></div></div></div>
<div class="pg" id="pg-roblox"> <div class="ph"><button class="ph-hbg" onclick="openMobSB()">☰</button><div class="ph-logo"><img src="https://i.imgur.com/KxtzMhw.png" onerror="this.style.display='none'" alt=""><div class="logo-fb" style="display:none">F</div></div><div class="ph-titles"><div class="ph-h1">Roblox Tools</div><div class="ph-sub">15 Roblox utilities</div></div><div class="ph-sp"></div><span class="ph-bc" style="background:linear-gradient(135deg,#e2231a,#ff6b6b)">15 Tools</span></div><div class="pc"><div class="tgrid" id="g-roblox"></div></div></div>
<div class="pg" id="pg-games">  <div class="ph"><button class="ph-hbg" onclick="openMobSB()">☰</button><div class="ph-logo"><img src="https://i.imgur.com/KxtzMhw.png" onerror="this.style.display='none'" alt=""><div class="logo-fb" style="display:none">F</div></div><div class="ph-titles"><div class="ph-h1">Games</div><div class="ph-sub">100 games — all have ▶ Start &amp; 🔁 Retry</div></div><div class="ph-sp"></div><span class="ph-bc">100 Games</span></div><div class="pc"><div class="ggrid" id="g-games"></div></div></div>

</div><!-- /main -->
</div><!-- /app -->

<!-- MODAL -->
<div id="mod-ov" onclick="if(event.target===this)closeMod()">
  <div id="mod-box">
    <div class="mhd"><span class="mhd-i" id="mod-ico"></span><h2 class="mhd-t" id="mod-tit">Tool</h2><button class="mcls" onclick="closeMod()">✕</button></div>
    <div class="mbody" id="mod-body"></div>
  </div>
</div>

<!-- GAME OVERLAY -->
<div id="gmod">
  <div class="ghd"><span class="g-ico" id="g-ico"></span><div class="g-ttl" id="g-ttl">Game</div><button class="gcls" onclick="closeGame()">✕</button></div>
  <div id="gsc">—</div>
  <canvas id="gcv" style="display:none"></canvas>
  <div id="gdom"></div>
  <div id="gov"><div id="govt"></div><div id="govs"></div></div>
  <div id="gbtns">
    <button class="gbtn gbtn-s" id="gbstart" onclick="startGame()">▶ START</button>
    <button class="gbtn gbtn-r" id="gbretry" onclick="retryGame()">🔁 RETRY</button>
    <button class="gbtn gbtn-c" onclick="closeGame()">✕ CLOSE</button>
  </div>
</div>

<script>
// ════════ NAVIGATION ════════
window.goPage = function(id, btn) {
  document.querySelectorAll('.pg').forEach(p => p.classList.remove('on'));
  const pg = document.getElementById('pg-' + id);
  if (pg) { pg.classList.add('on'); const pc = pg.querySelector('.pc'); if (pc) pc.scrollTop = 0; }
  document.querySelectorAll('.sbtn').forEach(b => b.classList.remove('act'));
  if (btn) btn.classList.add('act');
  closeMobSB();
};

// ════════ SIDEBAR ════════
let _sbCollapsed = false;
window.toggleSB = function() {
  _sbCollapsed = !_sbCollapsed;
  const sb = document.getElementById('sb');
  const arrow = document.getElementById('sb-arrow');
  if (_sbCollapsed) {
    sb.classList.add('col');
    arrow.textContent = '▶';
  } else {
    sb.classList.remove('col');
    arrow.textContent = '◀';
  }
};
window.openMobSB = function() {
  document.getElementById('sb').classList.add('mob-open');
  document.getElementById('sb-ov').classList.add('on');
};
window.closeMobSB = function() {
  document.getElementById('sb').classList.remove('mob-open');
  document.getElementById('sb-ov').classList.remove('on');
};

// ════════ MODAL ════════
let _MT = [];
window.openMod = function(ico, title, html, cb) {
  document.getElementById('mod-ico').textContent = ico;
  document.getElementById('mod-tit').textContent = title;
  document.getElementById('mod-body').innerHTML = html;
  document.getElementById('mod-ov').classList.add('on');
  if (cb) setTimeout(cb, 60);
};
window.closeMod = function() {
  document.getElementById('mod-ov').classList.remove('on');
  document.getElementById('mod-body').innerHTML = '';
  _MT.forEach(t => { clearInterval(t); clearTimeout(t); });
  _MT = [];
};

// ════════ HELPERS ════════
const $ = id => document.getElementById(id);
const val = id => { const e = $(id); return e ? e.value : ''; };
const setv = (id, v) => { const e = $(id); if (e) e.value = v; };
const set = (id, v) => { const e = $(id); if (e) e.textContent = v; };
const seth = (id, v) => { const e = $(id); if (e) e.innerHTML = v; };
const esc = s => String(s).replace(/&/g,'&amp;').replace(/</g,'&lt;').replace(/>/g,'&gt;').replace(/"/g,'&quot;');
const gcd = (a, b) => b ? gcd(b, a % b) : a;
window.cp = function(txt) {
  if (navigator.clipboard) navigator.clipboard.writeText(txt).catch(() => {});
  alert('Copied: ' + (txt.length > 80 ? txt.slice(0, 80) + '...' : txt));
};
window.addTimer = t => { _MT.push(t); return t; };

// ════════ CARD BUILDERS ════════
window.mkTool = function(grid, ico, name, cat, fn) {
  const g = $('g-' + grid); if (!g) return;
  const d = document.createElement('div'); d.className = 'tc';
  d.innerHTML = `<div class="tc-i">${ico}</div><div class="tc-n">${name}</div><div class="tc-c">${cat}</div>`;
  d.onclick = fn; g.appendChild(d);
};
window.mkGame = function(ico, name, desc, key) {
  const g = $('g-games'); if (!g) return;
  const d = document.createElement('div'); d.className = 'gc';
  d.innerHTML = `<div class="gc-i">${ico}</div><div class="gc-n">${name}</div><div class="gc-d">${desc}</div><div class="gc-p">▶ PLAY</div>`;
  d.onclick = () => launchGame(key, ico, name); g.appendChild(d);
};

// ════════ GAME ENGINE ════════
let _raf = null, _gName = '', _gStarted = false;
window.launchGame = function(name, ico, title) {
  _gName = name; _gStarted = false;
  $('g-ico').textContent = ico; $('g-ttl').textContent = title;
  $('gsc').textContent = '—'; $('gov').style.display = 'none';
  $('gbstart').style.display = 'inline-block'; $('gbretry').style.display = 'none';
  $('gcv').style.display = 'none'; $('gdom').innerHTML = '';
  $('gmod').classList.add('on'); cancelAnimationFrame(_raf); _cleanG();
  const info = window._GI && window._GI[name] || 'Press START to play';
  $('gdom').innerHTML = `<div style="font-size:13px;color:var(--t3);text-align:center;padding:12px;max-width:540px;line-height:1.6">${esc(info)}</div>`;
};
window.startGame = function() {
  _gStarted = true; $('gov').style.display = 'none';
  $('gbstart').style.display = 'none'; $('gbretry').style.display = 'none';
  cancelAnimationFrame(_raf); _cleanG();
  $('gdom').innerHTML = ''; $('gcv').style.display = 'none'; runGame(_gName);
};
window.retryGame = function() {
  $('gov').style.display = 'none'; $('gbretry').style.display = 'none';
  cancelAnimationFrame(_raf); _cleanG();
  $('gdom').innerHTML = ''; $('gcv').style.display = 'none'; runGame(_gName);
};
window.closeGame = function() {
  $('gmod').classList.remove('on'); cancelAnimationFrame(_raf); _cleanG();
  $('gdom').innerHTML = ''; $('gcv').style.display = 'none'; _gStarted = false;
};
function _cleanG() {
  if (window._gkd) { document.removeEventListener('keydown', window._gkd); window._gkd = null; }
  if (window._gku) { document.removeEventListener('keyup', window._gku); window._gku = null; }
  if (window._giv) { clearInterval(window._giv); window._giv = null; }
  if (window._giv2) { clearInterval(window._giv2); window._giv2 = null; }
  if (window._gto) { clearTimeout(window._gto); window._gto = null; }
}
window.gameOver = function(title, stats) {
  cancelAnimationFrame(_raf);
  $('govt').textContent = title; $('govs').textContent = stats || '';
  $('gov').style.display = 'block';
  $('gbretry').style.display = 'inline-block'; $('gbstart').style.display = 'none';
};
window.getCV = function(sw, sh) {
  const cv = $('gcv');
  const mw = Math.min(sw, window.innerWidth - 24, 520);
  const cw = mw, ch = Math.round(mw * (sh / sw));
  cv.width = cw; cv.height = ch; cv.style.display = 'block';
  return { cv, c: cv.getContext('2d'), w: cw, h: ch, sx: cw/sw, sy: ch/sh };
};
window._GI = {};
window.runGame = function(n) {
  const m = window._GM || {};
  if (m[n]) m[n]();
  else $('gdom').innerHTML = '<div style="color:var(--t3);text-align:center;padding:20px">Load all parts to play.</div>';
};
window._GM = {};
</script>
