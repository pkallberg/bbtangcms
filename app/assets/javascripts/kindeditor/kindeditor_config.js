//KindEditor.options.items=["emoticons", "|", "forecolor", "hilitecolor", "fontsize", "bold", "strikethrough", "justifyleft", "justifycenter", "justifyright", "|", "image", "multiimage", "table",  "link", "unlink"]

KindEditor.options.pasteType = 1
KindEditor.options.allowFileManager = false

KindEditor.options.htmlTags = {
        font : ['color', 'size', 'face', '.background-color'],
        span : [
                '.color', '.background-color', '.font-size', '.font-family', '.background',
                '.font-weight', '.font-style', '.text-decoration', '.vertical-align', '.line-height'
        ],
        div : [
                'align', '.border', '.margin', '.padding', '.text-align', '.color',
                '.background-color', '.font-size', '.font-family', '.font-weight', '.background',
                '.font-style', '.text-decoration', '.vertical-align', '.margin-left'
        ],
        table: [
                'border', 'cellspacing', 'cellpadding', 'width', 'height', 'align', 'bordercolor',
                '.padding', '.margin', '.border', 'bgcolor', '.text-align', '.color', '.background-color',
                '.font-size', '.font-family', '.font-weight', '.font-style', '.text-decoration', '.background',
                '.width', '.height', '.border-collapse'
        ],
        'tbody,tr,b': [
                'align', '.text-align', '.vertical-align'
        ],
        'td,th': [
                'align', 'valign', 'width', 'height', 'colspan', 'rowspan', 'bgcolor',
                '.text-align', '.color', '.background-color', '.font-size', '.font-family', '.font-weight',
                '.font-style', '.text-decoration', '.vertical-align', '.background', '.border'
        ],
        a : ['href', 'target', 'name'],
        embed : ['src', 'width', 'height', 'type', 'loop', 'autostart', 'quality', '.width', '.height', 'align', 'allowscriptaccess'],
        img : ['src', 'width', 'height', 'border', 'alt', 'title', 'align', '.width', '.height', '.border'],
        'p,ol,ul,li,blockquote,h1,h2,h3,h4,h5,h6' : [
                'align', '.text-align', '.color', '.background-color', '.font-size', '.font-family', '.background',
                '.font-weight', '.font-style', '.text-decoration', '.vertical-align', '.text-indent', '.margin-left'
        ],
        pre : ['class'],
        hr : ['class', '.page-break-after'],
        'br,strong,sub,sup,em,i,u,strike,s,del' : []
}


//KindEditor.options.showRemote=false
//KindEditor.options.items= ["source", "|", "undo", "redo", "|", "preview", "print", "template", "code", "cut", "copy", "paste", "plainpaste", "wordpaste", "|", "justifyleft", "justifycenter", "justifyright", "justifyfull", "insertorderedlist", "insertunorderedlist", "indent", "outdent", "subscript", "superscript", "clearhtml", "quickformat", "selectall", "|", "fullscreen", "/", "formatblock", "fontname", "fontsize", "|", "forecolor", "hilitecolor", "bold", "italic", "underline", "strikethrough", "lineheight", "removeformat", "|", "image", "multiimage", "flash", "media", "insertfile", "table", "hr", "emoticons", "baidumap", "pagebreak", "anchor", "link", "unlink", "|", "about"]
