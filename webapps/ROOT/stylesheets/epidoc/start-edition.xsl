<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="2.0"
                xmlns:tei="http://www.tei-c.org/ns/1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <!-- Project-specific XSLT for transforming EpiDoc TEI to
       HTML. Customisations here override those in the core
       start-edition.xsl (which should not be changed). -->
  

  <xsl:import href="../../kiln/stylesheets/epidoc/start-edition.xsl" />
  <xsl:import href="htm-tpl-struct-telamon.xsl" />
  
  <xsl:template match="/" >
    <xsl:choose>
      <xsl:when test="$edn-structure='telamon'">
        <xsl:call-template name="telamon-structure">
          <xsl:with-param name="parm-internal-app-style" select="$internal-app-style" tunnel="yes"/>
          <xsl:with-param name="parm-external-app-style" select="$external-app-style" tunnel="yes"/>
          <xsl:with-param name="parm-edn-structure" select="$edn-structure" tunnel="yes"/>
          <xsl:with-param name="parm-edition-type" select="$edition-type" tunnel="yes"/>
          <xsl:with-param name="parm-hgv-gloss" select="$hgv-gloss" tunnel="yes"/>
          <xsl:with-param name="parm-leiden-style" select="$leiden-style" tunnel="yes"/>
          <xsl:with-param name="parm-line-inc" select="$line-inc" tunnel="yes" as="xs:double"/>
          <xsl:with-param name="parm-verse-lines" select="$verse-lines" tunnel="yes"/>
          <xsl:with-param name="parm-css-loc" select="$css-loc" tunnel="yes"/>
        </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
        <xsl:apply-imports/>
      </xsl:otherwise>
    </xsl:choose>
  
  </xsl:template>

</xsl:stylesheet>
