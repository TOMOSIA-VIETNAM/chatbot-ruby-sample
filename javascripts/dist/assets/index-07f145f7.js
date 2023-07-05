(function(){const r=document.createElement("link").relList;if(r&&r.supports&&r.supports("modulepreload"))return;for(const t of document.querySelectorAll('link[rel="modulepreload"]'))s(t);new MutationObserver(t=>{for(const n of t)if(n.type==="childList")for(const a of n.addedNodes)a.tagName==="LINK"&&a.rel==="modulepreload"&&s(a)}).observe(document,{childList:!0,subtree:!0});function o(t){const n={};return t.integrity&&(n.integrity=t.integrity),t.referrerPolicy&&(n.referrerPolicy=t.referrerPolicy),t.crossOrigin==="use-credentials"?n.credentials="include":t.crossOrigin==="anonymous"?n.credentials="omit":n.credentials="same-origin",n}function s(t){if(t.ep)return;t.ep=!0;const n=o(t);fetch(t.href,n)}})();const h="/assets/bot-61bdb6bf.svg",g="/assets/user-bcdeb18e.svg",c=document.querySelector("form"),i=document.querySelector("#chat_container");let d;window.location.hostname==="localhost"||window.location.hostname==="127.0.0.1"?d="http://127.0.0.1:3000/chat":d="http://openai-server.qlear.net/chat";let f;function v(e){e.textContent="",f=setInterval(()=>{e.textContent+=".",e.textContent==="...."&&(e.textContent="")},300)}function l(e,r){let o=0,s=setInterval(()=>{o<r.length?(e.innerHTML+=r.charAt(o),o++):clearInterval(s)},20)}function y(){const e=Date.now(),o=Math.random().toString(16);return`id-${e}-${o}`}function u(e,r,o){return`
        <div class="wrapper ${e&&"ai"}">
            <div class="chat">
                <div class="profile">
                    <img
                      src=${e?h:g}
                      alt="${e?"bot":"user"}"
                    />
                </div>
                <div class="message" id=${o}>${r}</div>
            </div>
        </div>
    `}const m=async e=>{e.preventDefault();const r=new FormData(c);i.innerHTML+=u(!1,r.get("prompt")),c.reset();const o=y();i.innerHTML+=u(!0," ",o),i.scrollTop=i.scrollHeight;const s=document.getElementById(o);v(s);const t=new FormData;t.append("prompt",r.get("prompt"));const n=await fetch(d,{method:"POST",body:t});if(clearInterval(f),s.innerHTML=" ",n.ok){const p=(await n.json()).bot.trim();l(s,p)}else{const a=await n.text();s.innerHTML="Something went wrong",l(s,a)}};c.addEventListener("submit",m);c.addEventListener("keyup",e=>{e.keyCode===13&&m(e)});
