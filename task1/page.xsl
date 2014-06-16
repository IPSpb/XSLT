<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="html"
                encoding="UTF-8"
                indent="yes"
                doctype-system="about:legacy-compat"/>

    <xsl:template match="/">
        <html>
            <head>
                <title>Платежная форма</title>
                <link rel="stylesheet" href="http://netdna.bootstrapcdn.com/bootstrap/3.1.1/css/bootstrap.min.css" />
            </head>
            <body>
                <div class="row">
                    <div class="col-md-1"></div>
                    <div class="col-md-4">
                        <h3>Форма</h3>
                        <form role="form" id="form1">
                            <div class="form-group">
                                <label for="exampleInputName">Имя</label>
                                <input type="text" name="name" class="form-control" value="" id="exampleInputName" placeholder="Введите имя" />
                            </div>
                            <div class="form-group">
                                <label for="exampleInputCity">Город</label>
                                <input type="text" name="city" class="form-control" value="" id="exampleInputCity" placeholder="Введите город" />
                            </div>
                            <div class="form-group">
                                <label for="exampleInputEmail1">Email</label>
                                <input type="email" name="email" class="form-control" id="exampleInputEmail1" placeholder="Ваш email" />
                            </div>
                        </form>
                    </div>
                    <div class="col-md-7">
                        <xsl:variable name="announcements" select="document('announcements.xml')/chapter"/>
                        <xsl:apply-templates select="/page/announcements-active">
                            <xsl:with-param name="announcements" select="$announcements"/>
                        </xsl:apply-templates>
                    </div>
                </div>
            </body>
        </html>
    </xsl:template>

    <xsl:template match="announcements-active" />
    <xsl:template match="announcements-active[item]">
        <xsl:param name="announcements"/>
        <ul class="list-unstyled">
            <xsl:apply-templates select="item">
                <xsl:with-param name="announcements" select="$announcements"/>
            </xsl:apply-templates>
        </ul>
    </xsl:template>

    <xsl:template match="item">
        <xsl:param name="announcements"/>
        <xsl:variable name="announcement" select="$announcements/section[@id = current()/@id]"/>
        <li>
            <xsl:apply-templates select="$announcement/title" mode="announcement-title"/>
            <xsl:apply-templates select="$announcement/para" mode="announcement-para"/>
        </li>
    </xsl:template>

    <xsl:template match="title" mode="announcement-title">
        <h4>
            <xsl:value-of select="."/>
        </h4>
    </xsl:template>

    <xsl:template match="para" mode="announcement-para">
        <p>
            <xsl:value-of select="."/>
        </p>
    </xsl:template>

</xsl:stylesheet>