// This is the Ubuntu manpage repository generator and interface.
//
// Copyright (C) 2008 Canonical Ltd.
//
// This code was originally written by Dustin Kirkland <kirkland@ubuntu.com>,
// based on a framework by Kees Cook <kees@ubuntu.com>.
//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with this program.  If not, see <http://www.gnu.org/licenses/>.
//
// On Debian-based systems, the complete text of the GNU General Public
// License can be found in /usr/share/common-licenses/GPL-3

function langSelect() {
    var regexS = "[\\?&]lr=([^&#]*)";
    var regex = new RegExp( regexS );
    var lang_val = regex.exec( window.location.href );
    document.write("<select name=lr>");
    lang = new Array();
    val = new Array();
    i = 0;
    lang[i] = "en"; val[i++] = "en";
    lang[i] = "cn"; val[i++] = "zh-CN";
    lang[i] = "cs"; val[i++] = "cs";
    lang[i] = "de"; val[i++] = "de";
    lang[i] = "es"; val[i++] = "es";
    lang[i] = "fr"; val[i++] = "fr";
    lang[i] = "hu"; val[i++] = "hu";
    lang[i] = "it"; val[i++] = "it";
    lang[i] = "ja"; val[i++] = "ja";
    lang[i] = "ko"; val[i++] = "ko";
    lang[i] = "nl"; val[i++] = "nl";
    lang[i] = "pl"; val[i++] = "pl";
    lang[i] = "pt"; val[i++] = "pt";
    lang[i] = "ru"; val[i++] = "ru";
    lang[i] = "sv"; val[i++] = "sv";
    lang[i] = "tr"; val[i++] = "tr";
    lang[i] = "tw"; val[i++] = "zh-TW";
    var selected = 0;
    for (j=0; j<i; j++) {
        if (lang_val != null && lang_val[1] == 'lang_' + val[j]) {
            selected = j;
        }
        document.write("<option value='lang_" + val[j] + "'>" + lang[j] + "</option>");
    }
    document.write("</select>");
    document.forms[0].lr.selectedIndex = selected;
}

function distroAndSection() {
    var parts = location.href.split("/");
    if (parts.length < 5) {
        return;
    }
    var distro = parts[4];
    var section = parts[5];
    section = section.replace(/^man/, "");
    if (!(section >= 1 && section <= 9)) {
        section = parts[6];
        section = section.replace(/^man/, "");
        var lang = parts[5];
    }
    if (distro.length > 0) {
        document.write("<a href=\"../\">" + distro + "</a> ");
        if (section.length > 0) {
            document.write("(<a href=\"../man" + section + "\">" + section + "</a>) ");
        }
    }
    var gz_href = location.href.replace(/\/manpages\//, "\/manpages.gz\/");
    gz_href = gz_href.replace(/\/en\//, "\/");
    gz_href = gz_href.replace(/\.html$/, "\.gz");
    var gz = gz_href.replace(/^.*\//, "");
    document.write("<a href=\"" + gz_href + "\">" + gz + "</a><br>");
}

function highlight(word) {
        if (location.href.match("/" + word)) {
                return("current");
        } else {
                return("plain");
        }
}
function navbar() {
        document.write("<ul>");
        versions = new Array();
        versions.push({"name":"lucid", "number":"10.04 LTS"});
        versions.push({"name":"precise", "number":"12.04 LTS"});
        versions.push({"name":"trusty", "number":"14.04 LTS"});
        versions.push({"name":"utopic", "number":"14.10"});
        for (var i=0; i<versions.length; i++) {
            if (location.href.match("\.html$")) {
            href = location.href;
            href = href.replace(/\/manpages\/[^\/]*/, "/manpages/" + versions[i]["name"]);
                document.write("<li class=\"active\" id=\"" + highlight(versions[i]["name"]) + "\"><a href=\"" + href + "\">" + versions[i]["number"] + "</a></li>");
        } else {
                    document.write("<li id=\"" + highlight(versions[i]["name"]) + "\"><a href=\"/manpages/" + versions[i]["name"] + "\">" + versions[i]["number"] + "</a></li>");
        }
        }
        document.write("<li><a href=\"javascript:printManpage()\"><img src=/img/printer.png></a></li>");
        document.write("</ul>");
}

// See: http://developer.mozilla.org/en/docs/Adding_search_engines_from_web_pages
function installSearchEngine() {
    if (window.external && ("AddSearchProvider" in window.external)) {
        // Firefox 2 and IE 7, OpenSearch
        window.external.AddSearchProvider("http://manpages.ubuntu.com/ubuntu-manpage-search.xml");
    } else if (window.sidebar && ("addSearchEngine" in window.sidebar)) {
        // Firefox <= 1.5, Sherlock
        window.sidebar.addSearchEngine("http://http://manpages.ubuntu.com/ubuntu-manpage-search.src",
        "http://manpages.ubuntu.com/ubuntu-manpage-search.png",
        "Ubuntu Manpages", "");
    } else {
        // No search engine support (IE 6, Opera, etc).
        alert("No search engine plugin support is available for this browser");
    }
}

function getWidth() {
    width = 0;
    if (parseInt(navigator.appVersion)>3) {
        if (navigator.appName=="Netscape") {
            width = window.innerWidth;
        } else if (navigator.appName.indexOf("Microsoft")!=-1) {
            width = document.body.offsetWidth;
        }
    }
    return width;
}

function printManpage() {
    var disp_setting="toolbar=no,location=no,directories=no,menubar=no,status=no,scrollbars=yes,width=600,height=400";
    var content = document.getElementById("content").innerHTML;
    var docprint = window.open("","",disp_setting);
    docprint.document.open();
    docprint.document.write('<html><head><title>Ubuntu Manpage Repository</title></head><body onLoad="self.print()">');
    docprint.document.write(content);
    docprint.document.write('<body></html>');
    docprint.document.close();
    docprint.focus();
}



//////////////////////////////////
// Google Analytics Code
var gaJsHost = (("https:" == document.location.protocol) ? "https://ssl." : "http://www.");
document.write(unescape("%3Cscript src='" + gaJsHost + "google-analytics.com/ga.js' type='text/javascript'%3E%3C/script%3E"));
try {
    var pageTracker = _gat._getTracker("UA-6958128-3");
    pageTracker._trackPageview();
} catch(err) {}
//////////////////////////////////


//////////////////////////////////
// This script was written By Brady Mulhollem - WebTech101.com
// http://www.webtech101.com/Javascript/toc-generator

window.onload = function(){if (getWidth() > 790) { new tocGen('content','toc')}};

function tocGen(id,writeTo){
    this.id = id;
    this.num = 0;
    this.opened = 0;
    this.writeOut = '';
    this.previous = 0;
    if(document.getElementById){
        //current requirements;
        this.parentOb = document.getElementById(id);
        var headers = this.getHeaders(this.parentOb);
        if(headers.length > 0){
            this.writeOut += '<ul>';
            var num;
            for(var i=0;i<headers.length;i++){
                num = headers[i].nodeName.substr(1);
                if(num > this.previous){
                    this.writeOut += '<ul>';
                    this.opened++;
                    this.addLink(headers[i]);
                }
                else if(num < this.previous){
                    for(var j=0;j<this.opened;j++){
                        this.writeOut += '<\/li><\/ul>';
                        this.opened--;
                    }
                    this.addLink(headers[i]);
                }
                else{
                    this.writeout += '<\/li>';
                    this.addLink(headers[i]);
                }
                this.previous = num;
            }
            for(var j=0;j<=this.opened;j++){
                this.writeOut += '<\/li><\/ul>';
            }
            document.getElementById(writeTo).innerHTML = this.writeOut;
        }
    }
}
tocGen.prototype.addLink = function(ob){
    var id = this.getId(ob);
    var link = '<li><a href="#'+id+'">'+ob.innerHTML.toLowerCase()+'<\/a>';
    this.writeOut += link;
}
tocGen.prototype.getId = function(ob){
    if(!ob.id){
        ob.id = this.id+'toc'+this.num;
        this.num++;
    }
    return ob.id;
}
tocGen.prototype.getHeaders = function(parent){
    var return_array = new Array();
    var pat = new RegExp("H[3-6]");
    for(var i=0;i<parent.childNodes.length;i++){
        if(pat.test(parent.childNodes[i].nodeName)){
            return_array[return_array.length] = parent.childNodes[i];
        }
    }
    return return_array;
}
/////////////////////////////////////////////////////////////////////////////////////
