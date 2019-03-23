<?xml version="1.0" encoding="UTF-8"?>
<!-- $Id$ -->
<xsl:stylesheet xmlns:i18n="http://apache.org/cocoon/i18n/2.1"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:t="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="t" version="2.0">
  <!-- Contains named templates for IOSPE file structure (aka "metadata" aka "supporting data") -->
  
  <!-- Called from htm-tpl-structure.xsl -->
  
  <xsl:template name="iospe-body-structure">
    <div id="stone">
      <h3><i18n:text i18n:key="epidoc-xslt-iospe-monument">Monument</i18n:text></h3>
      <table>
        <tr>
          <th scope="row">
            <i18n:text i18n:key="epidoc-xslt-iospe-monument-type">Type of monument</i18n:text>
          </th>
          <td>
            <xsl:choose>
              <xsl:when test="//t:support//t:objectType//text()">
                <xsl:value-of select="//t:support//t:objectType"/>
              </xsl:when>
              <xsl:otherwise><i18n:text i18n:key="epidoc-xslt-iospe-not-specified">Not specified</i18n:text></xsl:otherwise>
            </xsl:choose>
          </td>
        </tr>
        <tr>
          <th scope="row">
            <i18n:text i18n:key="epidoc-xslt-iospe-material">Material</i18n:text>
          </th>
          <td>
            <xsl:choose>
              <xsl:when test="//t:support//t:material//text()">
                <xsl:value-of select="//t:support//t:material"/>
              </xsl:when>
              <xsl:otherwise><i18n:text i18n:key="epidoc-xslt-iospe-not-specified">Not specified</i18n:text></xsl:otherwise>
            </xsl:choose>
          </td>
        </tr>
        <tr>
          <th scope="row">
            <i18n:text i18n:key="epidoc-xslt-iospe-find-place">Find place</i18n:text>
          </th>
          <td>
            <xsl:choose>
              <xsl:when test="//t:provenance[@type='found']//t:placeName[@type='ancientFindspot']//text()">
                <xsl:value-of select="//t:provenance[@type='found']//t:placeName[@type='ancientFindspot']"/>
              </xsl:when>
              <xsl:otherwise><i18n:text i18n:key="epidoc-xslt-iospe-unknown">Unknown</i18n:text></xsl:otherwise>
            </xsl:choose>
          </td>
        </tr>
        <tr>
          <th scope="row">
            <i18n:text i18n:key="epidoc-xslt-iospe-modern-location">Modern location</i18n:text>
          </th>
          <td>
            <xsl:choose>
              <xsl:when test="//t:provenance[@type='observed']//text()">
                <xsl:value-of select="//t:provenance[@type='observed']"/>
              </xsl:when>
              <xsl:otherwise><i18n:text i18n:key="epidoc-xslt-iospe-unknown">Unknown</i18n:text></xsl:otherwise>
            </xsl:choose>
          </td>
        </tr>
        <tr>
          <th scope="row">
            <i18n:text i18n:key="epidoc-xslt-iospe-dimensions">Dimensions</i18n:text>
          </th>
          <td>
            <xsl:choose>
              <xsl:when test="//t:support/t:dimensions//text()[not(normalize-space(.)=' ')]">
                <xsl:if test="//t:support/t:dimensions/t:height/text()[not(normalize-space(.)=' ')]"><i18n:text i18n:key="h">h.</i18n:text> <xsl:value-of select="//t:support/t:dimensions/t:height"/> <i18n:text i18n:key="cm">cm</i18n:text>,</xsl:if>
                <xsl:if test="//t:support/t:dimensions/t:width/text()[not(normalize-space(.)=' ')]"><i18n:text i18n:key="w"> w. </i18n:text> <xsl:value-of select="//t:support/t:dimensions/t:width"/> <i18n:text i18n:key="cm">cm</i18n:text>,</xsl:if>
                <xsl:if test="//t:support/t:dimensions/t:depth/text()[not(normalize-space(.)=' ')]"><i18n:text i18n:key="th"> th. </i18n:text> <xsl:value-of select="//t:support/t:dimensions/t:depth"/> <i18n:text i18n:key="cm">cm</i18n:text></xsl:if>
                <xsl:if test="//t:support/t:dimensions/t:dim[@type='diameter']/text()[not(normalize-space(.)=' ')]">, Diam. <xsl:value-of select="//t:support/t:dimensions/t:dim[@type='diameter']"/></xsl:if>
              </xsl:when>
              <xsl:otherwise><i18n:text i18n:key="epidoc-xslt-iospe-unknown">Unknown</i18n:text></xsl:otherwise>
            </xsl:choose>
          </td>
        </tr>
        <tr>
          <th scope="row">
            <i18n:text i18n:key="epidoc-xslt-iospe-institution-inventory">Institution and inventory</i18n:text>
          </th>
          <td>
            <xsl:choose>
              <xsl:when test="//t:msIdentifier//t:repository/text() and //t:msIdentifier//t:idno/ text()">
                <xsl:value-of select="//t:msIdentifier//t:repository"/>
                <xsl:value-of select="//t:msIdentifier//t:idno"/>
              </xsl:when>
              <xsl:when test="//t:msIdentifier//t:repository/text()">
                <xsl:value-of select="//t:msIdentifier//t:repository"/>
                <i18n:text i18n:key="no-inventary-number">no inventory number</i18n:text>
              </xsl:when>
              <xsl:otherwise><i18n:text i18n:key="epidoc-xslt-iospe-unavailable-pl">Not available.</i18n:text></xsl:otherwise>
            </xsl:choose>
          </td>
        </tr>
        <tr>
          <th scope="row">
            <i18n:text i18n:key="epidoc-xslt-iospe-letterheights">Letterheights</i18n:text>
          </th>
          <td>
            <xsl:choose>
              <xsl:when test="//t:handNote//t:height/text()">
                <xsl:value-of select="//t:handNote//t:height"/>
              </xsl:when>
              <xsl:otherwise><i18n:text i18n:key="epidoc-xslt-iospe-not-specified-m">Not specified</i18n:text></xsl:otherwise>
            </xsl:choose>
          </td>
        </tr>
        <tr>
          <th scope="row">
            <i18n:text i18n:key="epidoc-xslt-iospe-decoration">Decoration</i18n:text>
          </th>
          <td>
            <xsl:choose>
              <xsl:when test="//t:decoNote//text()">
                <xsl:value-of select="//t:decoNote//text()"/>
              </xsl:when>
              <xsl:otherwise><i18n:text i18n:key="epidoc-xslt-iospe-not-specified-m">Not specified</i18n:text></xsl:otherwise>
            </xsl:choose>
          </td>
        </tr>
      </table>
    </div>
    
    <div id="text">
      <h3><i18n:text i18n:key="epidoc-xslt-iospe-text">Text</i18n:text></h3>
      
      <table>
        <tr>
          <th scope="row">
            <i18n:text i18n:key="epidoc-xslt-iospe-category">Category</i18n:text>
          </th>
          <td>
            <xsl:choose>
              <xsl:when test="//t:msContents/t:summary/text()">
                <xsl:value-of select="//t:msContents/t:summary"/>
              </xsl:when>
              <xsl:otherwise><i18n:text i18n:key="epidoc-xslt-iospe-not-specified">Not specified</i18n:text></xsl:otherwise>
            </xsl:choose>
          </td>
        </tr>
        <tr>
          <th scope="row">
            <i18n:text i18n:key="epidoc-xslt-iospe-date">Date</i18n:text>
          </th>
          <td>
            <xsl:choose>
              <xsl:when test="//t:origin/t:origDate/text()">
                <xsl:value-of select="//t:origin/t:origDate"/>
              </xsl:when>
              <xsl:otherwise><i18n:text i18n:key="epidoc-xslt-iospe-not-specified">Not specified</i18n:text></xsl:otherwise>
            </xsl:choose>
          </td>
        </tr>
        <tr>
          <th scope="row">
            <i18n:text i18n:key="epidoc-xslt-iospe-dating-criteria">Dating criteria</i18n:text>
          </th>
          <td>
            <xsl:choose>
              <xsl:when test="//t:origin/t:origDate/@evidence">
                <xsl:for-each select="tokenize(//t:origin/t:origDate/@evidence,' ')">
                  <xsl:value-of select="translate(.,'-',' ')"/>
                  <xsl:if test="position()!=last()">
                    <xsl:text>, </xsl:text>
                  </xsl:if>
                </xsl:for-each>
              </xsl:when>
              <xsl:otherwise>
                <i18n:text i18n:key="epidoc-xslt-iospe-not-specified-letters">Not specified.</i18n:text>
              </xsl:otherwise>
            </xsl:choose>
          </td>
        </tr>
      </table>
      
      <div class="section-container tabs" data-section="tabs">
        <section>
          <p class="title" data-section-title="data-section-title"><a href="#"><i18n:text i18n:key="epidoc-xslt-inslib-edition">Interpretive</i18n:text></a></p>
          <div class="content" id="edition" data-section-content="data-section-content">
            <!-- Edited text output -->
            <xsl:variable name="edtxt">
              <xsl:apply-templates select="//t:div[@type='edition']">
                <xsl:with-param name="parm-edition-type" select="'interpretive'" tunnel="yes"/>
              </xsl:apply-templates>
            </xsl:variable>
            <!-- Moded templates found in htm-tpl-sqbrackets.xsl -->
            <xsl:apply-templates select="$edtxt" mode="sqbrackets"/>
          </div>
        </section>
        <section>
          <p class="title" data-section-title="data-section-title"><a href="#"><i18n:text i18n:key="epidoc-xslt-inslib-diplomatic">Diplomatic</i18n:text></a></p>
          <div class="content" id="diplomatic" data-section-content="data-section-content">
            <!-- Edited text output -->
            <xsl:variable name="edtxt">
              <xsl:apply-templates select="//t:div[@type='edition']">
                <xsl:with-param name="parm-edition-type" select="'diplomatic'" tunnel="yes"/>
              </xsl:apply-templates>
            </xsl:variable>
            <!-- Moded templates found in htm-tpl-sqbrackets.xsl -->
            <xsl:apply-templates select="$edtxt" mode="sqbrackets"/>
          </div>
        </section>
      </div>
      
      <div id="apparatus" >
        <h4 ><i18n:text i18n:key="epidoc-xslt-iospe-apparatus">Apparatus</i18n:text></h4>
        <!-- Apparatus text output -->
        <xsl:variable name="apptxt">
          <xsl:apply-templates select="//t:div[@type='apparatus']/t:listApp"/>
        </xsl:variable>
        <!-- Moded templates found in htm-tpl-sqbrackets.xsl -->
        <xsl:apply-templates select="$apptxt" mode="sqbrackets"/>
      </div>
      <div id="translation" >
        <h4 ><i18n:text i18n:key="epidoc-xslt-iospe-translation">Translation</i18n:text></h4>
        <!-- Translation text output -->
        <xsl:variable name="transtxt">
          <xsl:apply-templates select="//t:div[@type='translation']//t:p"/>
        </xsl:variable>
        <!-- Moded templates found in htm-tpl-sqbrackets.xsl -->
        <xsl:apply-templates select="$transtxt" mode="sqbrackets"/>
      </div>
      <div id="commentary" >
        <h4 ><i18n:text i18n:key="epidoc-xslt-iospe-commentary">Commentary</i18n:text></h4>
        <!-- Commentary text output -->
        <xsl:variable name="commtxt">
          <xsl:apply-templates select="//t:div[@type='commentary']//t:p"/>
        </xsl:variable>
        <!-- Moded templates found in htm-tpl-sqbrackets.xsl -->
        <xsl:apply-templates select="$commtxt" mode="sqbrackets"/>
      </div>
     <div id="bibliography">
        <h4 ><i18n:text i18n:key="epidoc-xslt-iospe-bibliography">Bibliography</i18n:text></h4>
        <xsl:apply-templates select="//t:body//t:div[@type='bibliography']//t:p"/>
      </div>
      <div id="images" >
        <h4 ><i18n:text i18n:key="epidoc-xslt-iospe-images">Images</i18n:text></h4>
        <dl>
          <xsl:for-each select="//t:facsimile//t:graphic">
            <dt width="150" align="left"></dt>
            <dd>
              <xsl:apply-templates select="." />
            </dd>
          </xsl:for-each>
        </dl>
      </div>
    </div>
  </xsl:template>
  
  <xsl:template name="iospe-structure">
    <xsl:variable name="title">
      <xsl:call-template name="iospe-title" />
    </xsl:variable>
    <html>
      <head>
        <title>
          <xsl:value-of select="$title"/>
        </title>
        <meta http-equiv="content-type" content="text/html; charset=UTF-8"/>
        <!-- Found in htm-tpl-cssandscripts.xsl -->
        <xsl:call-template name="css-script"/>
      </head>
      <body>
        <h1>
          <xsl:value-of select="$title"/>
        </h1>
        <xsl:call-template name="iospe-body-structure" />
      </body>
    </html>
  </xsl:template>
  
  <xsl:template name="iospe-title">
    <xsl:choose>
      <xsl:when test="//t:titleStmt/t:title/text() and matches(//t:idno[@type='filename'], '^\d\.\d{1,4}$')">
        <xsl:number value="substring-before(//t:idno[@type='filename'],'.')" format="I"/>
        <xsl:text>&#xa0;</xsl:text>
        <xsl:number value="substring-after(//t:idno[@type='filename'],'.')" format="1"/>
        <xsl:text>.&#xa0;</xsl:text>
        <xsl:if test="string(normalize-space(//t:origPlace[1]))"><xsl:value-of select="normalize-space(//t:origPlace[1])"/>
          <xsl:text>.&#xa0;</xsl:text></xsl:if>
        <xsl:value-of select="//t:titleStmt/t:title[child::text()][1]"/>
        <xsl:if test="not(//t:titleStmt/t:title[child::text()][1][child::t:origDate])">
          <xsl:text>,&#xa0;</xsl:text>
          <xsl:value-of select="//t:origDate[1]"/>
        </xsl:if>
      </xsl:when>
      <xsl:when test="//t:titleStmt/t:title/text()">
        <xsl:value-of select="//t:titleStmt/t:title"/>
      </xsl:when>
      <xsl:when test="//t:sourceDesc//t:bibl/text()">
        <xsl:value-of select="//t:sourceDesc//t:bibl"/>
      </xsl:when>
      <xsl:when test="//t:idno[@type='filename']/text()">
        <xsl:value-of select="//t:idno[@type='filename']"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:text>EpiDoc example output, IOSPE style</xsl:text>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
</xsl:stylesheet>
