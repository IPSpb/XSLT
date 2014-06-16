<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="html"
                encoding="UTF-8"
                indent="yes"
                doctype-system="about:legacy-compat"/>

    <xsl:param name="sortBy" select="'artist'" />
    <xsl:param name="order" select="'ascending'"/>
    <xsl:param name="artist"/>
    <xsl:param name="year"/>
    <xsl:template match="/">
        <html>
            <head>
                <title>recipes</title>
                <link rel="stylesheet" href="http://netdna.bootstrapcdn.com/bootstrap/3.1.1/css/bootstrap.min.css" />
            </head>
            <body>
                <xsl:variable name="node-set">
                    <xsl:choose>
                        <xsl:when test="$artist">
                            <xsl:value-of select="'catalog/cd[artist=$artist]'"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="'catalog/cd'"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:variable>
                <ul class="list-inline">
                    <xsl:variable name="data-type">
                        <xsl:choose>
                            <xsl:when test="$sortBy = 'year'">
                                <xsl:value-of select="'number'"/>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:value-of select="'text'"/>
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:variable>
                    <xsl:choose>
                        <xsl:when test="$artist and $year">
                            <xsl:apply-templates select="catalog/cd[artist=$artist and year=$year]" mode="cd">
                                <xsl:sort select="*[name()=$sortBy]" data-type="{$data-type}" order="{$order}" />
                            </xsl:apply-templates>
                        </xsl:when>
                        <xsl:when test="$artist">
                            <xsl:apply-templates select="catalog/cd[artist=$artist]" mode="cd">
                                <xsl:sort select="*[name()=$sortBy]" data-type="{$data-type}" order="{$order}" />
                            </xsl:apply-templates>
                        </xsl:when>
                        <xsl:when test="$year">
                            <xsl:apply-templates select="catalog/cd[year=$year]" mode="cd">
                                <xsl:sort select="*[name()=$sortBy]" data-type="{$data-type}" order="{$order}" />
                            </xsl:apply-templates>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:apply-templates select="catalog/cd" mode="cd">
                                <xsl:sort select="*[name()=$sortBy]" data-type="{$data-type}" order="{$order}" />
                            </xsl:apply-templates>
                        </xsl:otherwise>
                    </xsl:choose>
                </ul>
            </body>
        </html>
    </xsl:template>

    <xsl:template match="cd" mode="cd">
        <li>
            <div><img src="{cover/@link}"/></div>
            <div class="text-center"><strong>Испонитель:</strong> <xsl:value-of select="artist"/> (<xsl:value-of select="year"/>)</div>
            <div class="text-center"><strong>Название:</strong> <xsl:value-of select="title"/></div>
            <div class="text-center"><strong>Студия:</strong> <xsl:value-of select="studio"/></div>
        </li>
    </xsl:template>

</xsl:stylesheet>