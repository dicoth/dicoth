const LazyLoadImage = () => {
  const loadImg = (it) => {
    const testImage = document.createElement('img')
    testImage.src = it.getAttribute('data-src')
    testImage.addEventListener('load', () => {
      it.src = testImage.src
      it.style.backgroundImage = 'none'
      it.style.backgroundColor = 'transparent'
    })
    it.removeAttribute('data-src')
  }

  if (!('IntersectionObserver' in window)) {
    document.querySelectorAll('img').forEach((data) => {
      if (data.getAttribute('data-src')) {
        loadImg(data)
      }
    })
    return false
  }

  if (window.imageIntersectionObserver) {
    window.imageIntersectionObserver.disconnect()
    document.querySelectorAll('img').forEach(function (data) {
      window.imageIntersectionObserver.observe(data)
    })
  } else {
    window.imageIntersectionObserver = new IntersectionObserver((entries) => {
      entries.forEach((entrie) => {
        if ((typeof entrie.isIntersecting === 'undefined'
          ? entrie.intersectionRatio !== 0
          : entrie.isIntersecting) && entrie.target.getAttribute('data-src')) {
          loadImg(entrie.target)
        }
      })
    })
    document.querySelectorAll('img').forEach(function (data) {
      window.imageIntersectionObserver.observe(data)
    })
  }
}
const attachUrl = "/attachement/view/"
const vditor = new Vditor('vditor', {
  lang: 'en_US',
  counter: 5120,
  height: 600,
  editorName: 'vditor',
  tab: 'emoji, headings, bold, italic, strike, |, line, quote, list, ordered-list, check, code, inline-code, undo, redo, upload, link, table, preview, fullscreen, info, help',
  toolbar: [
    {
      name: 'emoji',
      tipPosition: 'ne',
    },
    {
      name: 'headings',
      tipPosition: 'ne',
    },
    {
      name: 'bold',
      tipPosition: 'ne',
    },
    {
      name: 'italic',
      tipPosition: 'ne',
    },
    {
      name: 'strike',
      tipPosition: 'ne',
    },
    {
      name: '|',
      tipPosition: 'ne',
    },
    {
      name: 'line',
      tipPosition: 'ne',
    },
    {
      name: 'quote',
      tipPosition: 'ne',
    },
    {
      name: 'list',
      tipPosition: 'ne',
    },
    {
      name: 'ordered-list',
      tipPosition: 'ne',
    },
    {
      name: 'check',
      tipPosition: 'ne',
    },
    {
      name: 'code',
      tipPosition: 'ne',
    },
    {
      name: 'inline-code',
      tipPosition: 'ne',
    },
    {
      name: 'undo',
      tipPosition: 'ne',
    },
    {
      name: 'redo',
      tipPosition: 'ne',
    },
    // {
    //   name: 'upload',
    //   tipPosition: 'ne',
    // },
    {
      name: 'link',
      tipPosition: 'ne',
    },
    {
      name: 'table',
      tipPosition: 'ne',
    },
    // {
    //   name: 'record',
    //   tipPosition: 'ne',
    // },
    {
      name: 'preview',
      tipPosition: 'ne',
    },
    {
      name: 'fullscreen',
      tipPosition: 'ne',
    },

  ],
  upload: {
    accept: 'image/*,.pdf',
    token: 'test',
    url: '/api/upload/editor',
    // url: '/upload/editor',
    linkToImgUrl: '/api/upload/fetch',
    filename(name) {
      // ? \ / : | < > * [ ] white to -
      return name.replace(/\?|\\|\/|:|\||<|>|\*|\[|\]|\s+/g, '-')
    },
    handler(file) {
      // return 'handler'
    },
  },
  preview: {
    show: true,
    parse: () => {
      vditor.getHTML().then((res) => {
        var patt1 = /src\=\"attach:(\w+)/g

        var ImageTag = res.match(patt1)
        console.log(ImageTag)
        if (ImageTag && ImageTag.length != 0) {
          ImageTag.forEach(function (item, index) {
            var imgId = item.replace('src="attach:', '')
            console.log(imgId)
            var replaceHtml = `src="/attachment/` + imgId
            res = res.split(item).join(replaceHtml);
            vditor.renderPreview(res)
          })
        }
      })
    },
  },
})


$('#uploader').on('click', '.button', function () {
  var dataName = $(this).attr("data-name")
  var dataLink = $(this).find('.data-link').text()
  var dataId = $(this).find('.data-id').text()
  var imgHtml = ''
  if(dataName.indexOf('png')>-1 || dataName.indexOf('jpg')>-1 || dataName.indexOf('gif')>-1){
    imgHtml = '![' + dataName + '](attach:' + dataId + ')'
  }else {
    var imgHtml = '[' + dataName + '](attach:' + dataId + ')'
  }
  vditor.insertValue(imgHtml)
})
