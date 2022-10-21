<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="2.0"
                xmlns:kiln="http://www.kcl.ac.uk/artshums/depts/ddh/kiln/ns/1.0"
                xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
                xmlns:tei="http://www.tei-c.org/ns/1.0"
                xmlns:xi="http://www.w3.org/2001/XInclude"
                xmlns:fn="http://www.w3.org/2005/xpath-functions"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:xs="http://www.w3.org/2001/XMLSchema">

  <!-- XSLT to convert index metadata and index Solr results into
       HTML. This is the common functionality for both TEI and EpiDoc
       indices. It should be imported by the specific XSLT for the
       document type (eg, indices-epidoc.xsl). -->

  <xsl:import href="to-html.xsl" />

  <xsl:template match="index_metadata" mode="title">
    <xsl:value-of select="tei:div/tei:head" />
  </xsl:template>

  <xsl:template match="index_metadata" mode="head">
    <xsl:apply-templates select="tei:div/tei:head/node()" />
  </xsl:template>

  <xsl:template match="tei:div[@type='headings']/tei:list/tei:item">
    <th scope="col">
      <xsl:apply-templates/>
    </th>
  </xsl:template>

  <xsl:template match="tei:div[@type='headings']">
    <thead>
      <tr>
        <xsl:apply-templates select="tei:list/tei:item"/>
      </tr>
    </thead>
  </xsl:template>
  
  <xsl:template match="result/doc[arr[@name='index_coordinates']]"> <!-- i.e. locations index -->
    <div id="{str[@name='index_id']}" class="monument">
      <h2><xsl:apply-templates select="str[@name='index_item_name']" /></h2>
      <h3><xsl:value-of select="string-join(arr[@name='index_item_alt_name']/str, '; ')"/></h3>
      
      <xsl:if test="arr[@name='index_coordinates']">
        <div class="row map_box">
        <div id="{str[@name='index_id']}-map" class="mini-map"></div>
          <script type="text/javascript">
            <xsl:value-of select="fn:doc(concat('file:',system-property('user.dir'),'/webapps/ROOT/assets/scripts/maps.js'))"/>
            var mymap = L.map('<xsl:value-of select="str[@name='index_id']"/>-map', { center: [35.15, 33.45], zoom: 7.4, fullscreenControl: true, layers: layers });
            L.control.layers(baseMaps, overlayMaps).addTo(mymap);
            L.control.scale().addTo(mymap);
            L.Control.geocoder().addTo(mymap);
            var marker = L.marker([<xsl:value-of select="arr[@name='index_coordinates']/str[1]"/>]).addTo(mymap).bindPopup('<b>Coordinates:</b><br/><xsl:value-of select="arr[@name='index_coordinates']/str[1]"/>');
          </script>
      </div>
      </xsl:if>
      
      <div>
        <!--<p><b>Type: </b><xsl:value-of select="str[@name='index_item_type']" /></p>-->
        <p><b>District: </b><xsl:value-of select="string-join(arr[@name='index_district']/str, '; ')"/>
          <b> &#xA0;&#xA0;&#xA0;&#xA0; Diocese: </b><xsl:value-of select="string-join(arr[@name='index_diocese']/str, '; ')"/></p>
        <p><b>Context: </b><xsl:value-of select="string-join(arr[@name='index_context']/str, '; ')"/>
          <b> &#xA0;&#xA0;&#xA0;&#xA0; Function: </b><xsl:value-of select="string-join(arr[@name='index_function']/str, '; ')"/></p>
        <!--<p><b>Coordinates: </b><xsl:value-of select="string-join(arr[@name='index_coordinates']/str, '; ')"/></p>-->
        <p><b>Architectural type: </b><xsl:value-of select="string-join(arr[@name='index_architectural_type']/str, '; ')"/></p>
        <p><b>Date of construction: </b><xsl:value-of select="string-join(arr[@name='index_construction']/str, '; ')"/></p>
        <p><b>Date of painted decoration: </b></p>  
        <ul><xsl:for-each select="arr[@name='index_mural']/str"><li><xsl:value-of select="."/></li></xsl:for-each></ul>
        <p><b>State of preservation of the murals: </b><xsl:value-of select="string-join(arr[@name='index_conservation']/str, '; ')"/></p>
        <p><b>Donor(s): </b><xsl:value-of select="string-join(arr[@name='index_donors']/str, '; ')"/></p>
        <p><b>Painter(s): </b><xsl:value-of select="string-join(arr[@name='index_painter']/str, '; ')"/></p>
        <p><b>Graffiti: </b><xsl:apply-templates select="arr[@name='index_graffiti']"/></p>
        <p><b>External resources: </b></p>
        <ul><xsl:for-each select="arr[@name='index_external_resource']/str"><li><xsl:apply-templates select="."/></li></xsl:for-each></ul>
        <p><b>Edition(s) of inscriptions: </b><xsl:apply-templates select="arr[@name='index_inscriptions_bibl']"/></p>
        <p><b>Monument bibliography: </b><xsl:apply-templates select="arr[@name='index_monument_bibl']"/></p>
        <p><b>Inscriptions: </b></p>
        <ul class="index-instances"><xsl:apply-templates select="arr[@name='index_instance_location']/str"/></ul>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="result/doc[not(arr[@name='index_coordinates'])]"> <!-- i.e. all indices excluded locations -->
    <tr>
      <xsl:apply-templates select="str[@name='index_item_name']" />
      <xsl:apply-templates select="str[@name='index_surname']" />
      <xsl:apply-templates select="str[@name='index_abbreviation_expansion']"/>
      <xsl:apply-templates select="str[@name='index_numeral_value']"/>
      <xsl:apply-templates select="arr[@name='language_code']"/>
      <xsl:apply-templates select="arr[@name='index_epithet']" />
      <xsl:apply-templates select="str[@name='index_item_type']" />
      <xsl:apply-templates select="str[@name='index_item_role']" />
      <xsl:apply-templates select="str[@name='index_honorific']" />
      <xsl:apply-templates select="str[@name='index_secular_office']" />
      <xsl:apply-templates select="str[@name='index_dignity']" />
      <xsl:apply-templates select="str[@name='index_ecclesiastical_office']" />
      <xsl:apply-templates select="str[@name='index_occupation']" />
      <xsl:apply-templates select="str[@name='index_relation']" />
      <xsl:apply-templates select="str[@name='index_inscription_date']" />
      <xsl:apply-templates select="arr[@name='index_instance_location']" />
    </tr>
  </xsl:template>

  <xsl:template match="response/result[descendant::doc[arr[@name='index_coordinates']]]"> <!-- i.e. locations index -->
    <div>
      <xsl:if test="doc/str[@name='index_map_points']">
        <div class="row map_box">
        <div id="mapid" class="map"></div>
        <script type="text/javascript">
          var points = <xsl:value-of select="doc/str[@name='index_map_points']"/>;
          var map_labels = <xsl:value-of select="doc/str[@name='index_map_labels']"/>;
          <xsl:value-of select="fn:doc(concat('file:',system-property('user.dir'),'/webapps/ROOT/assets/scripts/maps.js'))"/>
          var mymap = L.map('mapid', { center: [35.15, 33.45], zoom: 8.5, fullscreenControl: true, layers: layers });
          L.control.layers(baseMaps, overlayMaps).addTo(mymap);
          L.control.scale().addTo(mymap);
          L.Control.geocoder().addTo(mymap);
          toggle_places.addTo(mymap); 
        </script>
      </div>
      </xsl:if>
      
      <h2>MONUMENTS</h2>
      <xsl:apply-templates select="doc[descendant::str[@name='index_item_type'][.='Monument']]"><xsl:sort select="lower-case(.)"/></xsl:apply-templates>
      <h2>REPOSITORIES</h2>
      <xsl:apply-templates select="doc[descendant::str[@name='index_item_type'][.='Repository']]"><xsl:sort select="lower-case(.)"/></xsl:apply-templates>
    </div>
  </xsl:template>
  
  <xsl:template match="response/result[not(descendant::arr[@name='index_coordinates'])]"> <!-- i.e. all indices excluded locations -->
    <table class="index tablesorter">
      <xsl:apply-templates select="/aggregation/index_metadata/tei:div/tei:div[@type='headings']" />
      <tbody>
        <xsl:apply-templates select="doc"><xsl:sort select="translate(normalize-unicode(lower-case(.),'NFD'), '&#x0300;&#x0301;&#x0308;&#x0303;&#x0304;&#x0313;&#x0314;&#x0345;&#x0342;' ,'')"/></xsl:apply-templates>
      </tbody>
    </table>
  </xsl:template>

  <xsl:template match="str[@name='index_abbreviation_expansion']">
    <td>
      <xsl:value-of select="." />
    </td>
  </xsl:template>

  <xsl:template match="str[@name='index_item_name']">
    <th scope="row" class="item_name">
      <xsl:value-of select="."/>
      <!-- if persons index: show popup with info from persons.xml AL -->
      <xsl:if test="ancestor::doc[descendant::str[@name='index_surname']]">
        <br/><button type="button" class="expander" onclick="$(this).next().toggleClass('shown'); $(this).text($(this).next().hasClass('shown') ? '[Collapse]' : '[Expand]');">[Expand]</button>
        <span class="expanded">
          <xsl:text>Forename: </xsl:text><xsl:value-of select="ancestor::doc/str[@name='index_item_name']"/>
          <br/><xsl:text>Surname: </xsl:text><xsl:value-of select="ancestor::doc/str[@name='index_surname']"/>
          <br/><xsl:text>Greek name: </xsl:text><xsl:for-each select="ancestor::doc/arr[@name='index_item_alt_name']/str"><xsl:apply-templates select="."/><xsl:if test="position()!=last()">. </xsl:if></xsl:for-each>
          <br/><xsl:text>Period: </xsl:text><xsl:value-of select="ancestor::doc/str[@name='index_floruit']"/>
          <br/><xsl:text>Secular office: </xsl:text><xsl:value-of select="ancestor::doc/str[@name='index_secular_office']"/>
          <br/><xsl:text>Ecclesiastical office: </xsl:text><xsl:value-of select="ancestor::doc/str[@name='index_ecclesiastical_office']"/>
          <br/><xsl:text>Occupation: </xsl:text><xsl:value-of select="ancestor::doc/str[@name='index_occupation']"/>
          <br/><xsl:text>Association with monument: </xsl:text><xsl:value-of select="ancestor::doc/str[@name='index_relation']"/>
          <br/><xsl:text>Notes: </xsl:text><xsl:value-of select="ancestor::doc/str[@name='index_note']"/>
          <br/><xsl:for-each select="ancestor::doc/arr[@name='index_external_resource']/str"><xsl:apply-templates select="."/><xsl:if test="position()!=last()"><br/></xsl:if></xsl:for-each>
        </span>
      </xsl:if>
    </th>
  </xsl:template>
  
  <xsl:template match="str[@name='index_surname']">
    <td>
      <xsl:value-of select="."/>
    </td>
  </xsl:template>
  
  <xsl:template match="str[@name='index_honorific']">
    <td>
      <xsl:value-of select="."/>
    </td>
  </xsl:template>
  
  <xsl:template match="str[@name='index_secular_office']">
    <td>
      <xsl:value-of select="."/>
    </td>
  </xsl:template>
  
  <xsl:template match="str[@name='index_dignity']">
    <td>
      <xsl:value-of select="."/>
    </td>
  </xsl:template>

  <xsl:template match="str[@name='index_ecclesiastical_office']">
    <td>
      <xsl:value-of select="."/>
    </td>
  </xsl:template>
  
  <xsl:template match="str[@name='index_occupation']">
    <td>
      <xsl:value-of select="."/>
    </td>
  </xsl:template>
  
  <xsl:template match="str[@name='index_relation']">
    <td>
      <xsl:value-of select="."/>
    </td>
  </xsl:template>
  
  <xsl:template match="str[@name='index_inscription_date']">
    <td>
      <xsl:value-of select="."/>
    </td>
  </xsl:template>
  
  <xsl:template match="arr[@name='index_instance_location']">
    <td>
      <ul class="index-instances inline-list">
        <xsl:apply-templates select="str" />
      </ul>
    </td>
  </xsl:template>
  
  <xsl:template match="str[@name='index_item_type']">
    <td>
      <xsl:value-of select="."/>
    </td>
  </xsl:template>
  
  <xsl:template match="str[@name='index_item_role']">
    <td>
      <xsl:value-of select="."/>
    </td>
  </xsl:template>

  <xsl:template match="str[@name='index_numeral_value']">
    <td>
      <xsl:value-of select="."/>
    </td>
  </xsl:template>

  <xsl:template match="arr[@name='language_code']">
    <td>
      <ul class="inline-list">
        <xsl:apply-templates select="str"/>
      </ul>
    </td>
  </xsl:template>

  <xsl:template match="arr[@name='language_code']/str">
    <li>
      <xsl:value-of select="."/>
    </li>
  </xsl:template>
  
  <xsl:template match="str[@name='index_id']">
    <td>
      <xsl:value-of select="."/>
    </td>
  </xsl:template>
  
  <xsl:template match="arr[@name='index_epithet']">
    <td>
      <xsl:variable name="epithets">
        <xsl:for-each select="str">
          <xsl:value-of select="."/>
          <xsl:if test="position()!=last()"><xsl:text>, </xsl:text></xsl:if>
        </xsl:for-each>
      </xsl:variable>
      <xsl:value-of select="string-join(distinct-values(tokenize($epithets, ', ')), ', ')"/>
    </td>
  </xsl:template>
  
  <xsl:template match="arr[@name='index_inscriptions_bibl']|arr[@name='index_monument_bibl']">
    <xsl:for-each select="str[.='unpublished']"><xsl:value-of select="."/></xsl:for-each>  
    <xsl:for-each select="str[.!='unpublished']">
        <xsl:variable name="bibl-id">
          <xsl:choose>
            <xsl:when test="contains(., ',')">
              <xsl:value-of select="substring-before(., ',')"/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:value-of select="."/>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <xsl:variable name="bibliography-al" select="concat('file:',system-property('user.dir'),'/webapps/ROOT/content/xml/authority/bibliography.xml')"/>
        <xsl:variable name="bibl" select="document($bibliography-al)//tei:bibl[@xml:id=$bibl-id][not(@sameAs)]"/>
        <a href="{concat('../../concordance/bibliography/',$bibl-id,'.html')}" target="_blank">
          <xsl:choose>
            <xsl:when test="doc-available($bibliography-al) = fn:true() and $bibl//tei:surname and $bibl//tei:date">
              <xsl:for-each select="$bibl//tei:surname[not(parent::*/preceding-sibling::tei:title)]">
                <xsl:apply-templates select="."/>
                <xsl:if test="position()!=last()"> – </xsl:if>
              </xsl:for-each>
              <xsl:text> </xsl:text>
              <xsl:apply-templates select="$bibl//tei:date"/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:value-of select="$bibl-id"/>
            </xsl:otherwise>
          </xsl:choose>
        </a>
      <xsl:if test="contains(., ',')">
        <xsl:text>, </xsl:text>
        <xsl:value-of select="substring-after(., ',')"/>
      </xsl:if>
        <xsl:if test="position()!=last()">; </xsl:if>
      </xsl:for-each>
  </xsl:template>
  
  
  <xsl:template match="arr[@name='index_external_resource']/str">
    <xsl:value-of select="substring-before(., ': ')"/><xsl:text>: </xsl:text>
    <a target="_blank" href="{substring-after(., ': ')}"><xsl:value-of select="substring-after(., ': ')"/></a>
  </xsl:template>
  
  <xsl:template match="arr[@name='index_graffiti']">
    <xsl:for-each select="str">
      <xsl:analyze-string select="." regex="(http:|https:)(\S+?)(\.|\)|\]|;|,|\?|!|:)?(\s|$)">
        <xsl:matching-substring>
          <a target="_blank" href="{concat(regex-group(1),regex-group(2))}"><xsl:value-of select="concat(regex-group(1),regex-group(2))"/></a>
          <xsl:value-of select="concat(regex-group(3),regex-group(4))"/>
        </xsl:matching-substring>
        <xsl:non-matching-substring><xsl:value-of select="."/></xsl:non-matching-substring>
      </xsl:analyze-string>
      <xsl:if test="position()!=last()">; </xsl:if>
    </xsl:for-each>  
  </xsl:template>
  
  
  <xsl:template match="arr[@name='index_instance_location']/str">
    <!-- This template must be defined in the calling XSLT (eg,
         indices-epidoc.xsl) since the format of the location data is
         not universal. -->
    <xsl:call-template name="render-instance-location" />
  </xsl:template>

</xsl:stylesheet>
