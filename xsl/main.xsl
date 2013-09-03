<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
   version="1.0"
   xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output
    method="html"
    version="1.0"
    encoding="[cbinfo.html.encoding]"
    indent="yes"
    doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN"
    doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"
/>

<xsl:param name="debug">0</xsl:param>
<xsl:param name="module-css">[module.mobile.css]</xsl:param>
<xsl:param name="module-js">[module.mobile.js]</xsl:param>
<xsl:param name="module-ticket-jsp">[module.mobile.jsp]</xsl:param>
<xsl:param name="sessionid"></xsl:param>
<xsl:param name="profile"></xsl:param>
<xsl:param name="extent"></xsl:param>
<xsl:param name="cbinfo.map.minx"></xsl:param>
<xsl:param name="cbinfo.map.miny"></xsl:param>
<xsl:param name="cbinfo.map.maxx"></xsl:param>
<xsl:param name="cbinfo.map.maxy"></xsl:param>
<xsl:param name="cbinfo.map.srs"></xsl:param>
<xsl:param name="cbinfo.wms.host"></xsl:param>
<xsl:param name="cbinfo.map.resolutions"></xsl:param>
<xsl:param name="module.spatialaddress.filter"></xsl:param>
<xsl:param name="module.spatialaddress.apikey">trial</xsl:param>

<xsl:variable name="title.fallback"><xsl:choose>
    <xsl:when test="contains('[cbinfo.site.title]','cbinfo.site.title')">SpatialMap</xsl:when>
    <xsl:otherwise>[cbinfo.site.title]</xsl:otherwise>
</xsl:choose></xsl:variable>
<xsl:variable name="title"><xsl:choose>
    <xsl:when test="//row[@name='profile']/col[@name='profile.title']!=''"><xsl:value-of select="//row[@name='profile']/col[@name='profile.title']"/></xsl:when>
    <xsl:otherwise><xsl:value-of select="$title.fallback"/></xsl:otherwise>
</xsl:choose></xsl:variable>


<xsl:decimal-format decimal-separator="," grouping-separator="." />

<xsl:template match="/">
<html>
    <head>
        <title><xsl:value-of select="$title"/></title>
        <meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
        <meta charset="utf-8" />
        <link rel="apple-touch-icon" sizes="72x72" href="http://distribution.spatialsuite.com/spatialsuite-touch-icon.png"/>
        <meta name="apple-mobile-web-app-capable" content="yes"/>
        <meta name="apple-mobile-web-app-status-bar-style" content="black"/>
        <meta name="viewport" content="width=device-width, initial-scale=1"/> 
        <xsl:if test="$debug &gt; 0">
            <script type="text/javascript" language="javascript">/* XML SOURCE <xsl:copy-of select="."/> */ </script>
        </xsl:if>
        <link href="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8.13/themes/base/jquery-ui.css" type="text/css" rel="Stylesheet"></link>
        <link href="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8.13/themes/redmond/jquery-ui.css" type="text/css" rel="Stylesheet"></link>        
<!--         <link rel="stylesheet" href="http://code.jquery.com/mobile/1.0b3/jquery.mobile-1.0b3.min.css" /> -->
<!--         <script src="[cbinfo.jslib.jquery]"></script> -->
<!--         <script src="http://code.jquery.com/mobile/1.0b3/jquery.mobile-1.0b3.min.js"></script> -->

        <link rel="stylesheet" href="http://code.jquery.com/mobile/1.0.1/jquery.mobile-1.0.1.min.css" />
        <script src="http://code.jquery.com/jquery-1.6.4.min.js"></script>
        <script src="http://code.jquery.com/mobile/1.0.1/jquery.mobile-1.0.1.min.js"></script>
        <script src="[cbinfo.jslib.jqueryui]"></script>

        <xsl:element name="link">
            <xsl:attribute name="rel">Stylesheet</xsl:attribute>
            <xsl:attribute name="href"><xsl:value-of select="$module-css"/></xsl:attribute>
            <xsl:attribute name="type">text/css</xsl:attribute>
        </xsl:element>
        <xsl:variable name="cbinfo.spatialmap.jslib.mobile">[cbinfo.spatialmap.jslib.mobile]</xsl:variable>
        <xsl:choose>
            <xsl:when test="substring($cbinfo.spatialmap.jslib.mobile,0,2) = '['">
                <script type="text/javascript" src="/js/standard/spatialmap/1.3.0/api/SpatialMap.js?modules=mobile,events"></script>
            </xsl:when>
            <xsl:otherwise>
                <script type="text/javascript" src="[cbinfo.spatialmap.jslib.mobile]"></script>
            </xsl:otherwise>
        </xsl:choose>


        <script type="text/javascript" src="/js/standard/spatialmap/1.3.0/api/SpatialMap/Control/Click.js"></script>
        <script type="text/javascript" src="/js/standard/proj4js/proj4js-compressed.js"></script>
        <script type="text/javascript" src="/js/standard/themegroup.js"></script>
        <script type="text/javascript" src="/js/standard/theme.js"></script>
        <script type="text/javascript" src="/modules/mobile/js/legend.js"></script>
        <script type="text/javascript" src="[module.spatialserver.js.api]/SpatialServer.js?modules=spatialquery"></script>
        <script type="text/javascript">

        <xsl:choose>
            <xsl:when test="string-length($extent) > 0">
        var extent = '<xsl:value-of select="$extent"/>';
            </xsl:when>
            <xsl:otherwise>
        var extent = {
            x1:<xsl:value-of select="//pcomposite[@name='client']/pcomposite[@name='map']/row[@name='defaultextent']/col[@name='xmin']"/>,
            y1:<xsl:value-of select="//pcomposite[@name='client']/pcomposite[@name='map']/row[@name='defaultextent']/col[@name='ymin']"/>,
            x2:<xsl:value-of select="//pcomposite[@name='client']/pcomposite[@name='map']/row[@name='defaultextent']/col[@name='xmax']"/>,
            y2:<xsl:value-of select="//pcomposite[@name='client']/pcomposite[@name='map']/row[@name='defaultextent']/col[@name='ymax']"/>
        }</xsl:otherwise>
        </xsl:choose>
        
        var initOptions = {
            host: '/wms',
            extent: extent,
            profile: '<xsl:value-of select="$profile"/>',
            sessionId: '<xsl:value-of select="$sessionid"/>',
            resolutions: <xsl:choose><xsl:when test="string-length(//pcomposite[@name='client']/pcomposite[@name='map']/col[@name='resolutions']) > 0">[<xsl:value-of select="//pcomposite[@name='client']/pcomposite[@name='map']/col[@name='resolutions']"/>]</xsl:when><xsl:otherwise><xsl:choose><xsl:when test="string-length($cbinfo.map.resolutions) > 0">[<xsl:value-of select="$cbinfo.map.resolutions"/>]</xsl:when><xsl:otherwise>null</xsl:otherwise></xsl:choose></xsl:otherwise></xsl:choose>,
            maxextent: {<xsl:choose><xsl:when test="//pcomposite[@name='client']/pcomposite[@name='map']/row[@name='maxextent']">
                x1:<xsl:value-of select="//pcomposite[@name='client']/pcomposite[@name='map']/row[@name='maxextent']/col[@name='xmin']"/>,
                y1:<xsl:value-of select="//pcomposite[@name='client']/pcomposite[@name='map']/row[@name='maxextent']/col[@name='ymin']"/>,
                x2:<xsl:value-of select="//pcomposite[@name='client']/pcomposite[@name='map']/row[@name='maxextent']/col[@name='xmax']"/>,
                y2:<xsl:value-of select="//pcomposite[@name='client']/pcomposite[@name='map']/row[@name='maxextent']/col[@name='ymax']"/>
        </xsl:when>
        <xsl:otherwise>
            <xsl:choose>
                <xsl:when test="string-length($cbinfo.map.maxx) > 0">
                x1:<xsl:value-of select="$cbinfo.map.minx"/>,
                y1:<xsl:value-of select="$cbinfo.map.miny"/>,
                x2:<xsl:value-of select="$cbinfo.map.maxx"/>,
                y2:<xsl:value-of select="$cbinfo.map.maxy"/>
                </xsl:when>
                <xsl:otherwise></xsl:otherwise>
            </xsl:choose>
        </xsl:otherwise></xsl:choose>
            },
            projection: <xsl:choose><xsl:when test="string-length(//pcomposite[@name='client']/pcomposite[@name='map']/col[@name='srs']) > 0">'<xsl:value-of select="//pcomposite[@name='client']/pcomposite[@name='map']/col[@name='srs']"/>'</xsl:when><xsl:otherwise><xsl:choose><xsl:when test="string-length($cbinfo.map.srs) > 0">'<xsl:value-of select="$cbinfo.map.srs"/>'</xsl:when><xsl:otherwise>null</xsl:otherwise></xsl:choose></xsl:otherwise></xsl:choose>,
            spatialaddress: {
                apikey: '<xsl:value-of select="$module.spatialaddress.apikey"/>',
                area: '<xsl:value-of select="$module.spatialaddress.filter"/>'
            }
        }
        
        <xsl:if test="$debug &gt; 0">
        initOptions.debug = parseInt ('<xsl:value-of select="$debug"/>');
        </xsl:if>
        </script>
        <script type="text/javascript">
            <xsl:attribute name="src"><xsl:value-of select="$module-js"/></xsl:attribute>
        </script>
        <xsl:variable name="module.analytics.id">[module.analytics.id]</xsl:variable>
        <xsl:if test="substring($module.analytics.id,0,2) != '['">
            <script type="text/javascript">
            var _gaq = _gaq || [];
            _gaq.push(['_setAccount', '[module.analytics.id]']);
            _gaq.push(['_trackPageview']);
            (function() {
                var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
                ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
                var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
            })();
            setTimeout(function () {
                var pageTracker = _gat._getTracker('[module.analytics.id]');
                pageTracker._setCustomVar(1, 'profile', '<xsl:value-of select="$profile"/>', 3);
                pageTracker._trackEvent('Profile', 'Mobile-Load', '<xsl:value-of select="$profile"/>');
            }, 500);
            </script>
        </xsl:if>
        
        
        
        <!-- The only change -->
        <script type="text/javascript" src="/modules/mobile-singleselect/js/mobile.js"></script>
        
        
        
    </head>
    <body>
        <div data-role="page" data-fullscreen="true" id="mappage">
          <div data-role="header" style="display:none;">
            <h1>SpatialMap - Mobile</h1>
          </div>
          <div data-role="content">
            <div id="map"></div>
          </div>
          <div data-role="footer" data-position="fixed">
            <div data-role="navbar"> 
                <ul> 
                    <li><a href="#layerspage">Vælg lag</a></li>
                    <li><a href="#searchpage" id="search">Søg en adresse</a></li> 
                    <li><a href="#" id="locate">Her</a></li> 
                    <li><a href="#legendpage" id="legend">Signaturforklaring</a></li> 
                </ul> 
            </div>
          </div>
        </div>

        <div data-role="page" id="layerspage"> 
            <div data-role="header" data-theme="b" style="display:none;"> 
                <h1>SpatialMap - Temavælger</h1> 
                <a href="../../" data-icon="home" data-iconpos="notext" data-direction="reverse" class="ui-btn-right jqm-home">Home</a> 
            </div><!-- /header --> 
            <div data-role="content"> 
                <ul data-role="listview" data-filter="true" id="layerslist"> 
                </ul> 
            </div><!-- /content --> 
            <div data-role="footer" data-position="fixed">
                <div data-role="navbar"> 
                    <ul> 
                        <li><a data-rel="back" href="#">OK</a></li> 
                    </ul> 
                </div>
            </div>
        </div><!-- /page -->

        <div data-role="page" id="searchpage"> 
            <div data-role="header" data-theme="b" style="display:none;"> 
                <h1>SpatialMap - Søg adresse</h1> 
            </div><!-- /header --> 
            <div data-role="content">
                <input type="search" id="searchinput" value=""/>
                <ul data-role="listview" data-filter="false" id="searchlist">
                    <li data-role="list-divider" id="searchlistheader">History</li>
                </ul> 
            </div><!-- /content --> 
            <div data-role="footer" data-position="fixed">
                <div data-role="navbar"> 
                    <ul> 
                        <li><a data-rel="back" href="#">Tilbage</a></li> 
                    </ul> 
                </div>
            </div>
        </div><!-- /page -->

        <div data-role="page" id="legendpage"> 
            <div data-role="header" data-theme="b" style="display:none;"> 
                <h1>SpatialMap - Signaturforklaring</h1> 
                <a href="../../" data-icon="home" data-iconpos="notext" data-direction="reverse" class="ui-btn-right jqm-home">Home</a> 
            </div><!-- /header --> 
            <div data-role="content"> 
                <ul data-role="listview" id="legendlist"> 
                </ul> 
            </div><!-- /content --> 
            <div data-role="footer" data-position="fixed">
                <div data-role="navbar"> 
                    <ul> 
                        <li><a data-rel="back" href="#">Tilbage</a></li> 
                    </ul> 
                </div>
            </div>
        </div><!-- /page -->

        <div data-role="page" id="infopage"> 
            <div data-role="header" data-theme="b" style="display:none;"> 
                <h1>SpatialMap - Info</h1> 
                <a href="../../" data-icon="home" data-iconpos="notext" data-direction="reverse" class="ui-btn-right jqm-home">Home</a> 
            </div><!-- /header --> 
            <div data-role="content">
                <div id="infolist"></div>
            </div><!-- /content --> 
            <div data-role="footer" data-position="fixed">
                <div data-role="navbar"> 
                    <ul> 
                        <li><a data-rel="back" href="#">Tilbage</a></li> 
                    </ul> 
                </div>
            </div>
        </div><!-- /page -->

        <div data-role="page" id="testpage"> 
            <div data-role="header" data-theme="b" style="display:none;"> 
                <h1>SpatialMap - Signaturforklaring</h1> 
                <a href="../../" data-icon="home" data-iconpos="notext" data-direction="reverse" class="ui-btn-right jqm-home">Home</a> 
            </div><!-- /header --> 
            <div data-role="content"> 
                <div data-role="collapsible-set">
                
                    <div data-role="collapsible" data-collapsed="false">
                    <h3>Section 1</h3>
                    <p>I'm the collapsible set content for section B.</p>
                    </div>
                    
                    <div data-role="collapsible">
                    <h3>Section 2</h3>
                    <p>I'm the collapsible set content for section B.</p>
                    </div>
                    
                </div>
            </div><!-- /content --> 
            <div data-role="footer" data-position="fixed">
                <div data-role="navbar"> 
                    <ul> 
                        <li><a data-rel="back" href="#">Tilbage</a></li> 
                    </ul> 
                </div>
            </div>
        </div><!-- /page -->
    </body>
</html>
</xsl:template>
</xsl:stylesheet>