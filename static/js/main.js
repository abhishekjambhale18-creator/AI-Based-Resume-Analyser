// theme toggle
(function(){
  const root=document.documentElement,btn=document.getElementById('themeBtn');
  function apply(t){root.setAttribute('data-theme',t);if(btn)btn.textContent=t==='dark'?'🌙':'☀️';}
  let t='dark';try{t=localStorage.getItem('theme')||'dark'}catch(e){}
  apply(t);
  if(btn)btn.addEventListener('click',()=>{t=root.getAttribute('data-theme')==='dark'?'light':'dark';apply(t);try{localStorage.setItem('theme',t)}catch(e){}});
})();

// drag & drop upload
(function(){
  const dz=document.getElementById('dropzone'),inp=document.getElementById('resumeFile');
  if(!dz||!inp)return;
  const label=document.getElementById('fileLabel'),submit=document.getElementById('uploadBtn');
  const MAX=5*1024*1024;
  function show(){
    const f=inp.files[0];
    if(!f){label.textContent='No file chosen';submit.disabled=true;return;}
    const ext=f.name.split('.').pop().toLowerCase();
    if(!['pdf','docx'].includes(ext)){alert('Only PDF or DOCX files are allowed.');inp.value='';show();return;}
    if(f.size>MAX){alert('File is larger than 5 MB.');inp.value='';show();return;}
    label.textContent='📄 '+f.name;submit.disabled=false;
  }
  dz.addEventListener('click',()=>inp.click());
  inp.addEventListener('change',show);
  ['dragover','dragenter'].forEach(e=>dz.addEventListener(e,ev=>{ev.preventDefault();dz.classList.add('over')}));
  ['dragleave','drop'].forEach(e=>dz.addEventListener(e,ev=>{ev.preventDefault();dz.classList.remove('over')}));
  dz.addEventListener('drop',ev=>{if(ev.dataTransfer.files.length){inp.files=ev.dataTransfer.files;show();}});
  document.getElementById('uploadForm').addEventListener('submit',()=>{submit.textContent='Analyzing…';});
  show();
})();

// star rating
(function(){
  const box=document.getElementById('stars');if(!box)return;
  const input=document.getElementById('rating'),text=document.getElementById('ratingText');
  const words=['','Poor','Fair','Good','Very good','Excellent — loved it!'];
  const stars=[...box.children];
  function set(n){input.value=n;stars.forEach((s,i)=>s.classList.toggle('on',i<n));text.textContent=words[n]||'';}
  stars.forEach((s,i)=>s.addEventListener('click',()=>set(i+1)));
  set(5);
})();

// live table search
(function(){
  const s=document.getElementById('tableSearch');if(!s)return;
  s.addEventListener('input',()=>{
    const v=s.value.toLowerCase();
    document.querySelectorAll('#searchTable tbody tr').forEach(r=>{r.style.display=r.textContent.toLowerCase().includes(v)?'':'none';});
  });
})();

// confirm destructive actions
document.querySelectorAll('form[data-confirm]').forEach(f=>f.addEventListener('submit',e=>{if(!confirm(f.dataset.confirm))e.preventDefault();}));
