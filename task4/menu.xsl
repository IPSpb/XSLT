<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:exsl="http://exslt.org/common"
                extension-element-prefixes="exsl">
    <xsl:output method="html"
                encoding="UTF-8"
                indent="yes"
                doctype-system="about:legacy-compat"/>

    <xsl:template match="/">
        <html>
        <head>
            <title>Меню</title>
            <link rel="stylesheet" href="http://netdna.bootstrapcdn.com/bootstrap/3.1.1/css/bootstrap.min.css" />
        </head>
        <body>
            <xsl:variable name="menu-xml">
                <xsl:apply-templates select="root"/>
            </xsl:variable>
            <xsl:variable name="menu" select="exsl:node-set($menu-xml)"/>
            <xsl:apply-templates select="$menu" mode="menu"/>
        </body>
        </html>
    </xsl:template>

    <xsl:template match="root">
        <xsl:variable name="is-current-url" select="request/url"/>
        <items>
            <xsl:for-each select="project/page">
                <item>
                    <xsl:if test="$is-current-url = current()/.">
                        <xsl:attribute name="is-current">
                            <xsl:value-of select="'true'"/>
                        </xsl:attribute>
                    </xsl:if>
                    <title><xsl:value-of select="@name"/></title>
                    <url><xsl:value-of select="."/></url>
                </item>
            </xsl:for-each>
        </items>
    </xsl:template>

    <xsl:template match="items" mode="menu">
        <ul>
            <xsl:apply-templates select="item" mode="menu"/>
        </ul>
    </xsl:template>

    <xsl:template match="item" mode="menu">
        <li>
            <a href="{url}">
                <xsl:value-of select="title"/>
            </a>
        </li>
    </xsl:template>

    <xsl:template match="item[@is-current = 'true']" mode="menu">
        <li>
            <xsl:value-of select="title"/>
        </li>
    </xsl:template>
</xsl:stylesheet>