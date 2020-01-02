function picupload(config) {
    jQuery(function () {
        uploader = new Array();//创建 uploader数组
        file = new Array()
        // 优化retina, 在retina下这个值是2
        var ratio = window.devicePixelRatio || 1,
            thumbnailWidth = 100 * ratio,
            thumbnailHeight = 100 * ratio,
            supportTransition = (function () {
                var s = document.createElement('p').style,
                    r = 'transition' in s ||
                        'WebkitTransition' in s ||
                        'MozTransition' in s ||
                        'msTransition' in s ||
                        'OTransition' in s;
                s = null;
                return r;
            })();
        // 所有文件的进度信息，key为file id
        var percentages = {};
        var state = 'pedding';
        //可行性判断
        if (!WebUploader.Uploader.support()) {
            alert('Web Uploader  Your browser is not supported! If you are using IE browser, please try upgrading Flash Player ');
            throw new Error('WebUploader does not support the browser you are using.');
        }
        $('.uploder-container').each(function (index) {
            var fileCount = 0;            // 添加的文件数量
            var fileSize = 0;             // 添加的文件总大小
            var filePicker = $(this).find('.filePicker');//上传按钮实例
            var queueList = $(this).find('.queueList');//拖拽容器实例
            var jxfilePicker = $(this).find('.jxfilePicker');//继续添加按钮实例
            var placeholder = $(this).find('.placeholder');//按钮与虚线框实例
            var statusBar = $(this).find('.statusBar');//再次添加按钮容器实例
            var info = statusBar.find('.info');//提示信息容器实例
            var queue = $('<ul class="filelist"></ul>').appendTo(queueList);
            //初始化上传实例
            uploader[index] = WebUploader.create({
                pick: {
                    id: filePicker,
                    label: '上传'
                },
                dnd: queueList,
                //这里可以根据 index 或者其他，使用变量形式
                accept: config.accept,
                swf: 'res/Uploader.swf',
                disableGlobalDnd: true,//禁用浏览器的拖拽功能，否则图片会被浏览器打开
                chunked: false,//是否分片处理大文件的上传
                server: config.photoServer,//上传地址
                fileNumLimit: 10,//一次最多上传文件个数
                fileSizeLimit: config.fileSizeLimit,    // 总共的最大限制10M
                fileSingleSizeLimit: config.fileSingleSizeLimit,   // 单文件的最大限制3M
                auto: true,
                formData: {
                    token: index//可以在这里附加控件编号，从而区分是哪个控件上传的
                }
            });
            // 添加“添加文件”的按钮
            uploader[index].addButton({
                id: jxfilePicker,
                label: 'Add more'
            });
            //当文件加入队列时触发    uploader[0].upload();
            uploader[index].onFileQueued = function (file) {
                fileCount++;
                fileSize += file.size;
                if (fileCount === 1) {
                    placeholder.addClass('element-invisible');
                    statusBar.show();
                }
                addFile(file, uploader[index], queue);
                setState('ready', uploader[index], placeholder, queue, statusBar, jxfilePicker);
                updateStatus('ready', info, fileCount, fileSize);
            };
            //当文件被移除队列后触发。
            uploader[index].onFileDequeued = function (file) {
                fileCount--;
                fileSize -= file.size;
                if (!fileCount) {
                    setState('pedding', uploader[index], placeholder, queue, statusBar, jxfilePicker);
                    updateStatus('pedding', info, fileCount, fileSize);
                }
                removeFile(file);
            };
            var that = $(this);
            uploader[index].on('uploadSuccess', function (file, response) {
                // 上传成功
                var zs = response.picurl;
                // alert(response);
                // console.log(response)
                // alert(response.picurl);
                if(response.error_code == 10002 && response.filename){
                    zs = "https://mall-file.putaocdn.com/largefile/" + (response.filename).toLowerCase().split(".",1) + ".png";
                    // console.log(response.error_code);
                    // console.log(response.filename);
                }
                console.log(zs);
                if(zs && typeof(zs) != "undefined"){
                    var oldArray=[];
                    setArray(that, 1, oldArray);
                    oldArray.push(zs)
                    var nowArray = oldArray.join(',')
                    that.find('.number').val(nowArray);
                    alert('Upload succeed')
                }else{
                    alert('Upload failed');
                    $(".filelist li:last").remove();
                }
            });
            //可以在这里附加额外上传数据
            uploader[index].on('uploadBeforeSend', function (object, data, header) {
            });
            // 照片的回显
            var that = $(this);
            // 将input的值变为 数组
            // 老的数据
            var videoArray = [];
            setArray(that, 1, videoArray);
            for (var i = 0; i < videoArray.length; i++) {
                var obj = {};
                obj.size = '200*600';
                obj.url = videoArray[i];
                file[index] = new WebUploader.File(obj);
                file[index].setStatus('complete');
                uploader[index].addFiles(file[index])
            }
        });

        // 当有文件添加进来时执行，负责view的创建
        function addFile(file, now_uploader, queue) {
            var $li = $('<li id="' + file.id + '">' +
                '<p class="title">' + file.name + '</p>' +
                '<p class="imgWrap"></p>' +
                '<p class="progress"><span></span></p>' +
                '</li>'),
                $btns = $('<div class="file-panel">' +
                    '<span class="cancel">Del</span>' +
                    '<span class="rotateRight">rotate right</span>' +
                    '<span class="rotateLeft">rotate left</span></div>').appendTo($li),
                $prgress = $li.find('p.progress span'),
                $wrap = $li.find('p.imgWrap'),
                $info = $('<p class="error"></p>');

            $wrap.text('Previewing');
            if (file.flog == true) {
                var img = $('<img src="' + file.ret + '">');
                $wrap.empty().append(img);
            } else {
                now_uploader.makeThumb(file, function (error, src) {
                    if (error) {
                        if (file.source.url) {
                            var img = $('<img src="' + file.source.url + '">');
                            $wrap.empty().append(img);
                            // $img.attr('src', file.source.url);
                        } else {
                            $wrap.text('Cannot preview');
                        }
                        return;
                    }
                    var img = $('<img src="' + src + '">');
                    $wrap.empty().append(img);
                }, thumbnailWidth, thumbnailHeight);
            }
            percentages[file.id] = [file.size, 0];
            file.rotation = 0;
            $li.on('mouseenter', function () {
                $btns.stop().animate({height: 30});
            });
            $li.on('mouseleave', function () {
                $btns.stop().animate({height: 0});
            });
            $btns.on('click', 'span', function () {
                var index = $(this).index(),
                    deg;
                switch (index) {
                    case 0:
                        // 删除
                        var img = $btns.parents('li').find('.imgWrap').find('img').attr('src')
                        var videoOld = $(this).parents('.uploder-container').find('.number')
                        var delateThat = $(this);
                        var videoArray = [];
                        setArray(delateThat, 2, videoArray);
                        videoArray.splice(jQuery.inArray(img,videoArray),1);
                        console.log(videoArray)
                        var videoArrayString = videoArray.join(',')
                        // 删除之后重新修改
                        videoOld.val(videoArrayString)
                        now_uploader.removeFile(file);
                        return;
                    case 1:
                        file.rotation += 90;
                        break;

                    case 2:
                        file.rotation -= 90;
                        break;
                }
                if (supportTransition) {
                    deg = 'rotate(' + file.rotation + 'deg)';
                    $wrap.css({
                        '-webkit-transform': deg,
                        '-mos-transform': deg,
                        '-o-transform': deg,
                        'transform': deg
                    });
                } else {
                    $wrap.css('filter', 'progid:DXImageTransform.Microsoft.BasicImage(rotation=' + (~~((file.rotation / 90) % 4 + 4) % 4) + ')');
                }
            });
            $li.appendTo(queue);
        }

        // 负责view的销毁
        function removeFile(file) {
            var $li = $('#' + file.id);
            delete percentages[file.id];
            // 删除
            $li.off().find('.file-panel').off().end().remove();
        }

        function setState(val, now_uploader, placeHolder, queue, statusBar, jxfilePicker) {
            switch (val) {
                case 'pedding':
                    placeHolder.removeClass('element-invisible');
                    queue.parent().removeClass('filled');
                    queue.hide();
                    statusBar.addClass('element-invisible');
                    now_uploader.refresh();
                    break;
                case 'ready':
                    placeHolder.addClass('element-invisible');
                    jxfilePicker.removeClass('element-invisible');
                    queue.parent().addClass('filled');
                    queue.show();
                    statusBar.removeClass('element-invisible');
                    now_uploader.refresh();
                    break;
            }
        }

        function updateStatus(val, info, f_count, f_size) {
            // var text = '';
            // if (val === 'ready') {
            //     text = '选中' + f_count + '张图片，共' +
            //         WebUploader.formatSize(f_size) + '。';
            // }
            // info.html(text);
        }
    });
}

function setArray(that, type, array) {
    if (type == '1') {
        var videoOldArray = that.find('.number').val()
    } else if (type == '2') {
        var videoOldArray = that.parents('.uploder-container').find('.number').val()
    }
    // 字符串编程数组
    // var videoArray = [];
    // alert(videoOldArray);
    if (videoOldArray) {
        var videoArrays = videoOldArray.split(",");

        videoArrays.map(function (val, index) {
            if (val !== "" && val != undefined) {
                array.push(val);
            }
        });
    }
    return array
}