<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="2.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:ut="urn:jboss:domain:undertow:3.0"
                xmlns:dm="urn:jboss:domain:4.0"
                xmlns:ee="urn:jboss:domain:ee:4.0"
                xmlns:db="urn:jboss:domain:datasources:4.0"
                xmlns:log="urn:jboss:domain:logging:3.0">

  <xsl:output method="xml" indent="yes"/>

  <xsl:template match="//log:subsystem">
    <xsl:copy>
      <xsl:apply-templates select="node()|@*"/>
      <xsl:element name="logger" namespace="urn:jboss:domain:logging:3.0">
        <xsl:attribute name="category">org.keycloak</xsl:attribute>
        <xsl:element name="level" namespace="urn:jboss:domain:logging:3.0">
          <xsl:attribute name="name">DEBUG</xsl:attribute>
        </xsl:element>
      </xsl:element>
    </xsl:copy>
  </xsl:template> 
  
  <xsl:template match="@*|node()">
    <xsl:copy>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*|node()"/>
    </xsl:copy>
  </xsl:template>
    
    
</xsl:stylesheet>