<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="2.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:ut="urn:jboss:domain:undertow:3.0"
                xmlns:dm="urn:jboss:domain:4.0"
                xmlns:ee="urn:jboss:domain:ee:4.0"
                xmlns:db="urn:jboss:domain:datasources:4.0">

    <xsl:output method="xml" indent="yes"/>

 <xsl:template match="//db:subsystem/db:datasources/db:datasource[@jndi-name='java:jboss/datasources/ExampleDS']">
    
  </xsl:template>
  

  <!-- Postgres database configuration -->
  <xsl:template match="//db:subsystem/db:datasources/db:datasource[@jndi-name='java:jboss/datasources/KeycloakDS']">
    <xsl:copy>
      <xsl:apply-templates select="@*"/>
      <xsl:attribute name="enabled">true</xsl:attribute>
      <xsl:attribute name="pool-name">idamDS</xsl:attribute>
      <xsl:attribute name="use-ccm">true</xsl:attribute>
      <xsl:attribute name="use-java-context">true</xsl:attribute>
      <xsl:apply-templates select="node()"/>
    </xsl:copy>
  </xsl:template>
  
  <xsl:template match="//db:subsystem/db:datasources/db:datasource[@jndi-name='java:jboss/datasources/KeycloakDS']/db:connection-url">
    <xsl:copy>
      <xsl:text>jdbc:postgresql://172.17.0.2:5432/keycloak</xsl:text>
    </xsl:copy>
  </xsl:template>
  
  <xsl:template match="//db:subsystem/db:datasources/db:datasource[@jndi-name='java:jboss/datasources/KeycloakDS']/db:driver">
    <xsl:copy>
      <xsl:text>postgresql</xsl:text>
    </xsl:copy>
  </xsl:template>
  
  <xsl:template match="//db:subsystem/db:datasources/db:datasource[@jndi-name='java:jboss/datasources/KeycloakDS']/db:security/db:user-name">
    <xsl:copy>
      <xsl:text>keycloak</xsl:text>
    </xsl:copy>
  </xsl:template>
  
  <xsl:template match="//db:subsystem/db:datasources/db:datasource[@jndi-name='java:jboss/datasources/KeycloakDS']/db:security/db:password">
    <xsl:copy>
      <xsl:text>password</xsl:text>
    </xsl:copy>
  </xsl:template>
  
  
  <xsl:template match="//db:subsystem/db:datasources/db:drivers/db:driver">
    <xsl:copy>
      <xsl:attribute name="name">postgresql</xsl:attribute>
      <xsl:attribute name="module">org.postgresql.jdbc</xsl:attribute>
      <xsl:apply-templates select="node()"/>
    </xsl:copy>
  </xsl:template>
  
  <xsl:template match="//db:subsystem/db:datasources/db:drivers/db:driver/db:xa-datasource-class">
    <xsl:copy>
      <xsl:text>org.postgresql.xa.PGXADataSource</xsl:text>
    </xsl:copy>
  </xsl:template>

  <xsl:template match="//ee:subsystem/ee:default-bindings">
    <xsl:copy>
      <xsl:apply-templates select="@*"/>
      <xsl:attribute name="datasource">java:jboss/datasources/KeycloakDS</xsl:attribute>
      <xsl:attribute name="context-service">java:jboss/ee/concurrency/context/default</xsl:attribute>
      <xsl:attribute name="managed-executor-service">java:jboss/ee/concurrency/executor/default</xsl:attribute>
      <xsl:attribute name="managed-scheduled-executor-service">java:jboss/ee/concurrency/scheduler/default</xsl:attribute>
      <xsl:attribute name="managed-thread-factory">java:jboss/ee/concurrency/factory/default</xsl:attribute>
      <xsl:apply-templates select="node()"/>
    </xsl:copy>
  </xsl:template>
  
  
  
  <xsl:template match="@*|node()">
    <xsl:copy>
      <xsl:apply-templates select="@*|node()"/>
    </xsl:copy>
  </xsl:template>

</xsl:stylesheet>