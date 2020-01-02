/**
 * @author  funnyque@163.com (github:https://github.com/funnyque/easyUpload.js) (qq:1016981640)
 * @param   configs(required)
 * @return  Xhr object
 * @version 2.0.4
 * @description js file upload
 */
;(function (window, document) {
  var easyUploader = function (configs) {
    if (!configs || !configs.id) {
      alert('缺少配置参数');
      return;
    }
    if (!(this instanceof easyUploader)) return new easyUploader(configs);
    this.initPlugin(configs);
  };
  var inputImgArray = []
  var defaultConfigs = {
      id: "", 
      accept: '.jpg,.png',
      action: "", 
      autoUpload: true, 
      crossDomain: true, 
      data: null, 
      dataFormat: 'formData', 
      dataType: 'json', 
      headers: {
      
      }, 
      maxCount: 3, 
      maxSize: 3, 
      multiple: false,
      name: 'file', 
      previewWidth: 70, 
      processData: false,
      successKey: 'error_code', 
      successValue: 0, 
      showAlert: true, 
      timeout: 0, 
      withCredentials: true, 
      beforeUpload: null, 
      onAlert: null, 
      onChange: null, 
      onError: null, 
      onRemove: null, 
      onSuccess: null, 
    },
    iconFile = 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAEYAAABGCAMAAABG8BK2AAAAFVBMVEWZmZmZmZmZmZmZmZmZmZmZmZmZmZk9goCmAAAAB3RSTlMC/rYs1mCR8/Hv3QAAAYBJREFUWMPtmMsSwyAIRRWE///kGmMTH6CYtN0012knC+cU4Uq0zj169CkhqEI7hb2uYOZQnA2cx/GQHjeOFRP0qcHOQe9phLFyCAeBckwc3C1hxDgYchBJEZaYSIgcHpVHE1bRpAzxulUKDuzrCUoVcPOVLCo9t0fjUOGw7k4qaxxyduPPShzQkx8xcHDCOykyZ4zBwysHJnFwEXN4pZhHAmeGeXuFi6UI8Uwx2SuYNn9W6LbXHJM5rUtpFZM9hxCi/P7V7i4LpvYc1oVrMBDOQTVGyKmGwX7dJ6bnqNHwKaCuGbYcFSM3Topb1G0frjkrmLTQzSNpVMVZwaQSjbqYERNBZ0dlE0bpwYKNFgt+BeNKDF/HlF3YXcdYzgn/iklNSRZd9I3YL23RsKp8eHwKfhdDqhh/X/APYVDX11JMC0cBCYOcu7t3dzDUv2tuYGDh0CbmJr2Llw60Ixd/DWO9+3FbnfYobg1mNDFdRufyfrSmzLFodoFGYoPo+a9jVS+3Nw2jSs30KQAAAABJRU5ErkJggg=='; // 非图像文件预览的base64编码
  var fileStrList = []
  
  easyUploader.prototype = {
    configs: {}, 
    files: [],
    fileId: 0, 
    fileObj: {
      fileList: [], 
      isReady: true 
    },
    node: {
      list: null,
      input: null
    },
    ajax: {
      example: null,
      isReady: true,
      index: 0, 
    },
    initPlugin: function (configs) {
      this.configs = this.assignObject({}, defaultConfigs, configs);
      var container = document.getElementById(this.configs.id);
      if (!container) {
        return;
      } else {
        container.innerHTML = this.buildUploader();
        this.bindHeadEvent();
      }
      this.startInterceptor();
    },
    assignObject: function (target, source1, source2) {
      target = source1;
      Object.keys(source2).forEach(function (key) {
        if (target[key] != undefined) {
          target[key] = source2[key]
        }
      });
      return target;
    },
    buildUploader: function () {
      var html = '';
      html += '<div class="easy-uploader">'
        + '<div class="btn-box">'
        + '<span class="btn-select-file btn">'
        + 'Add attachments'
        + '</span>'
        + '<i class="btn-check-all cursor-select checkbox unchecked"></i>'
        + '<input class="input-file" type="file" accept="' + this.configs.accept + '" '
        + (this.configs.multiple ? 'multiple="multiple" ' : '')
        + 'style="display:none;"></input>'
        + '</div>'
        + '<ul class="list">'
        + '</ul>'
        + '</div>';
      return html;
    },
    updateHeadDom: function () {
      let isAllChecked = true;
      

      this.files.forEach(function (item) {
        if (!item.checked) {
          isAllChecked = false;
        }
      });
      if (isAllChecked) {
        $(this.node.input).siblings('.checkbox').removeClass('unchecked').addClass('checked');
      } else {
        $(this.node.input).siblings('.checkbox').removeClass('checked').addClass('unchecked');
      }
    },
    updateFilesDom: function () {
      var that = this,
        html = '';
      var buildCheckBox = function (fileItem) {
          if (that.configs.multiple) {
            if (fileItem.checked) {
              return '<i class="btn-check-item select-icon cursor-select checkbox checked"></i>';
            } else {
              return '<i class="btn-check-item select-icon cursor-select checkbox unchecked"></i>';
            }
          } else {
            return '';
          }
        },
        matchProgressBtn = function (fileItem) {
          if (fileItem.uploadPercentage == 0) {
            if (fileItem.uploadStatus == 'loading') {
              return '';
            } else {
              return '';
            }
          } else {
            if (fileItem.uploadStatus == 'error') {
              return '';
            } else if(fileItem.ajaxResponse) {
              return (
                '<div class="button" data-name = ' +
                fileItem.ajaxResponse.filename +
                '>Add to the post ' +
                '<span class="data-link">' +
                fileItem.ajaxResponse.url +
                '</span>' +
                '<span class="data-id">' +
                fileItem.ajaxResponse.id +
                '</span></div></div>'
              );
            }
          }
        },
        matchProgressText = function (fileItem) {
          if (fileItem.uploadPercentage == 0) {
            if (fileItem.uploadStatus == 'loading') {
              return 'Loading';
            } else {
              return '0%';
            }
          } else {
            if (fileItem.uploadStatus == 'error') {
              return 'Failed';
            } else {
              return (fileItem.uploadPercentage + '%');
            }
          }
        };
      this.files.forEach(function (fileItem, index) {
        html += '<li id="' + fileItem.id + '" class="list-item">'
          + '<div class="preview">'
          + '<img class="preview-img" src="' + fileItem.previewBase + '" />'
          + '</div>'
          + '<div class="info">'
          + '<div class="info-title">'
          + '<p class="filename">'
          + fileItem.file.name
          + '</p>'
          + '<div class="btn-area">'
          + matchProgressBtn(fileItem)
          + '</div>'
          + '</div>'
          + '<div class="progress-wrapper">'
          + '<div class="progressbar" style="width:' + fileItem.uploadPercentage + '%;'
          + (fileItem.uploadStatus == 'error' ? 'background-color:#f56c6c' : '') + '">'
          + '</div>'
          + '<div class="progress-text">'
          + matchProgressText(fileItem)
          + '</div>'
          + '</div>'
          + buildCheckBox(fileItem)
          + '</div>'
          + '<label class="btn-delete-item delete-label cursor-select">'
          + '<i class="delete-icon">X</i>'
          + '</label>'
          + '</li>';
      });
      this.node.list.html(html);
      this.bindListEvent();
      this.updateHeadDom();
    },
    bindHeadEvent: function () {
      var that = this;
      $(".btn-select-file").off("click").on("click", function () {
        that.node.list = $(this).parent().siblings(".list");
        $(this).parent().children(".input-file").trigger("click").on("change", function (e) {
          that.fileObj = {fileList: e.target.files, isReady: true};
          that.node.input = $(this);
          that.updateFiles();
          that.configs.onChange && that.configs.onChange(e.target.files);
        });
      });
      $(".btn-upload-file").off("click").on("click", function () {
        var hasLoading = false;
        that.files.forEach(function (item) {
          if (item.uploadStatus == 'loading') {
            hasLoading = true;
          }
        });
        if (hasLoading) {
          if (that.ajax.isReady) {
            var message = 'Uploading...';
            if (that.configs.showAlert) {
              alert(message);
            }
            that.configs.onAlert && that.configs.onAlert(message);
          } else {
            that.ajax.isReady = true;
            that.upload();
          }
        } else {
          that.ajax.isReady = true;
          that.upload();
        }
      });
      $(".btn-delete-file").off("click").on("click", function () {
        var hasLoading = false;
        that.files.forEach(function (item) {
          if (item.checked && item.uploadStatus == 'loading') {
            hasLoading = true;
          }
        });
        if (hasLoading) {
          var message = 'Uploading...';
          if (that.configs.showAlert) {
            alert(message);
          }
          that.configs.onAlert && that.configs.onAlert(message);
        } else {
          var newFiles = [];
          that.ajax.isReady = false;
          that.files.forEach(function (item) {
            if (!item.checked) {
              newFiles.push(item);
            }
          });
          that.files = newFiles;
          that.updateFilesDom();
          that.ajax.isReady = true;
        }
      });
      $(".btn-cancel-upload").off("click").on("click", function () {
        that.ajax.isReady = false;
        that.ajax.example.abort();
        that.files.forEach(function (item) {
          if (item.uploadStatus == 'loading') {
            item.uploadStatus = 'waiting';
          }
        });
        that.updateFilesDom();
      });
      $(".btn-check-all").off("click").on("click", function () {
        var isChecked = true;
        if ($(this).hasClass('checked')) {
          isChecked = false;
          $(this).removeClass('checked').addClass('unchecked');
        } else {
          isChecked = true;
          $(this).removeClass('unchecked').addClass('checked');
        }
        that.files.forEach(function (item) {
          item.checked = isChecked;
          if (!item.checked && item.uploadStatus == 'loading') {
            item.uploadStatus = 'waiting';
          }
        });
        that.updateFilesDom();
      });
    },
    bindListEvent: function () {
      var id = undefined,
        that = this;
      $(".btn-delete-item").off("click").on("click", function () {
        id = $(this).parent().attr('id');
        if ((that.files[that.ajax.index] && that.files[that.ajax.index].id == id) && that.files[that.ajax.index].uploadStatus == 'loading') {
          var message = 'Uploading...';
          if (that.configs.showAlert) {
            alert(message);
          }
          that.configs.onAlert && that.configs.onAlert(message);
        } else {
          that.ajax.isReady = false;
          that.files.forEach(function (item, index) {
            if (item.id == id) {
              that.files.splice(index, 1);
            }
          });
          that.updateFilesDom();
          that.ajax.isReady = true;
        }
      });
      $(".btn-check-item").off("click").on("click", function () {
        id = $(this).parent().parent().attr('id');
        that.files.forEach(function (item, index) {
          if (item.id == id) {
            if (item.checked) {
              item.checked = false;
              if (item.uploadStatus == 'loading') {
                item.uploadStatus = 'waiting';
              }
            } else {
              item.checked = true;
            }
          }
        });
        that.updateFilesDom();
      });
    },
    checkImg: function (file) {
      var imgTypes = ['image/jpeg', 'image/jpg', 'image/png', 'image/gif'],
        isImg = false;
      imgTypes.forEach(function (type) {
        if (file.type == type) isImg = true;
      });
      return isImg;
    },
    convertToBase: function (file) {
      var reader,
        isImg = this.checkImg(file);
      if (typeof FileReader !== 'undefined') {
        reader = new FileReader();
      } else {
        if (window.FileReader) reader = new window.FileReader();
      }
      reader.onload = (e) => {
        var base = e.target.result;
        if (isImg) {
          this.compressImg(base, file);
        } else {
          this.formatFile(file, iconFile, base);
        }
      }
      reader.readAsDataURL(file);
    },
    compressImg: function (base, file) {
      var img;
      if (typeof Image !== 'undefined') {
        img = new Image();
      } else {
        if (window.Image) img = new window.Image();
      }
      var drawImg = (img, w, h) => {
        var canvas = document.createElement('canvas');
        var ctx = canvas.getContext('2d');
        var drawImage = ctx.drawImage;
        ctx.drawImage = (img, sx, sy, sw, sh, dx, dy, dw, dh) => {
          var vertSquashRatio = 1;
          if (arguments.length == 9)
            drawImage.call(ctx, img, sx, sy, sw, sh, dx, dy, dw, dh / vertSquashRatio);
          else if (typeof sw != 'undefined') {
            drawImage.call(ctx, img, sx, sy, sw, sh / vertSquashRatio);
          } else {
            drawImage.call(ctx, img, sx, sy);
          }
        }
        canvas.width = w;
        canvas.height = h;
        ctx.drawImage(img, 0, 0, w, h);
        var previewBase = canvas.toDataURL('image/png');
        this.formatFile(file, previewBase, base);
      };
      img.onload = () => {
        var w = this.configs.previewWidth,
          h = w;
        drawImg(img, w, h);
      }
      img.src = base;
    },
    formatFile: function (file, previewBase, base) {
      this.files.push({
        ajaxResponse: undefined,
        base: base,
        checked: false,
        file: file,
        id: this.fileId,
        isImg: this.checkImg(file),
        previewBase: previewBase,
        uploadPercentage: 0,
        uploadStatus: 'waiting',
      });
      this.fileId++;
      this.updateFilesDom();
      this.fileObj.isReady = true;
    },
    updateFiles: function (type) {
      var existingCout = this.files.length, 
        index = 0,
        isSizeOver = false,
        timer = null,
        that = this;
      var onAlert = function (message) {
        if (that.configs.showAlert) {
          alert(message);
        }
        if (that.configs.onAlert) {
          that.configs.onAlert(message);
        }
      }
      timer = setInterval(function () {
        if (that.fileObj.isReady) {
          if (that.fileObj.fileList[index] && that.fileObj.fileList[index].size > that.configs.maxSize * (1024 * 1024)) {
            isSizeOver = true;
            index++;
          }
          if (that.files.length < that.configs.maxCount && index < that.fileObj.fileList.length) {
            that.fileObj.isReady = false;
            that.convertToBase(that.fileObj.fileList[index]);
            index++;
          } else {
            var countDiff = that.fileObj.fileList.length + existingCout - that.configs.maxCount,
              fileSize = that.fileObj.fileList[index - 1] ? (that.fileObj.fileList[index - 1].size / (1024 * 1024)).toFixed(2) : 0,
              message = '';
            if (that.configs.multiple && that.fileObj.fileList.length > 1) {
              if (countDiff > 0 && isSizeOver) {
                message = 'Files are over' + countDiff + 'counts；some files size are too big，allowed size is' + that.configs.maxSize + 'M';
                onAlert(message);
              } else if (countDiff > 0 && !isSizeOver) {
                message = 'Files are over' + countDiff + 'counts';
                onAlert(message);
              } else if (countDiff <= 0 && isSizeOver) {
                message = 'Some files size are too big，allowed size is' + that.configs.maxSize + 'M';
                onAlert(message);
              }
            } else {
              if (countDiff > 0 && fileSize > that.configs.maxSize) {
                message = 'File counts are over，file size are over；current file size is' + fileSize + 'M，allowed file size is' + that.configs.maxSize + 'M';
                onAlert(message);
              } else if (countDiff > 0 && fileSize <= that.configs.maxSize) {
                message = 'File counts are over';
                onAlert(message);
              } else if (countDiff <= 0 && fileSize > that.configs.maxSize) {
                message = 'file size are over；current file size is' + fileSize + 'M，allowed file size is' + that.configs.maxSize + 'M';
                onAlert(message);
              }
            }
            $(that.node.input).val("");
            clearInterval(timer);
            if (that.configs.autoUpload) {
              that.files.forEach(function (item) {
                item.checked = true;
              });
              that.upload();
            }
          }
        }
      }, 10);
    },
    startInterceptor: function () {
      var that = this;
      $.ajaxSetup({
        crossDomain: that.configs.crossDomain,
        xhrFields: {
          withCredentials: that.configs.withCredentials
        },
        beforeSend: function () {
          that.configs.beforeUpload && that.configs.beforeUpload(that.files[that.ajax.index], that.configs.data, arguments);
        }
      });
    },
    upload: function () {
      console.log(fileStrList)
      if (this.ajax.isReady) { 
        var that = this,
          hasChecked = false,
          checkedWaitingFiles = [];
        that.files.forEach(function (item) {
          if (item.checked) {
            hasChecked = true;
            if (item.uploadStatus == 'waiting' || (item.uploadStatus == 'loading' && item.uploadPercentage == 0)) {
              checkedWaitingFiles.push(item);
            }
          }
        });
        if (hasChecked) {
          if (checkedWaitingFiles.length) {
            that.files.forEach(function (item, index) {
              if (item.id == checkedWaitingFiles[0].id) {
                that.ajax.index = index;
              }
            });
            checkedWaitingFiles.forEach(function (item1) {
              that.files.forEach(function (item2) {
                if (item1.id == item2.id) {
                  item2.uploadStatus = 'loading';
                }
              });
            });
            this.updateFilesDom();
            if (this.configs.dataFormat == 'formData') {
              var fileName = this.files[this.ajax.index].file.name
              let checkRepeatResult = checkRepeat(fileStrList, fileName)
              if (checkRepeatResult) {
                alert('Same file is allowed to upload once')
                return
              } else {
                this.configs.data = new FormData();
                this.configs.data.append(this.configs.name, this.files[this.ajax.index].file);
              }
            } else {
              this.configs.data = {};
            }
            this.ajax.example = $.ajax({
              url: that.configs.action,
              type: "POST",
              contentType: false,
              data: that.configs.data,
              dataType: that.configs.dataType,
              headers: that.configs.headers,
              processData: that.configs.processData,
              timeout: that.configs.timeout,
              xhr: function () {
                var myXhr = $.ajaxSettings.xhr();
                if (myXhr.upload) {
                  myXhr.upload.addEventListener('progress', function (e) {
                    that.files[that.ajax.index].uploadPercentage = Math.floor(100 * e.loaded / e.total);
                    that.updateFilesDom();
                  }, false);
                }
                return myXhr;
              },
              success: function (res) {
                if (res[that.configs.successKey] == that.configs.successValue) {
                  that.files[that.ajax.index].uploadPercentage = 100;
                  that.files[that.ajax.index].uploadStatus = 'success';
                  that.files[that.ajax.index].ajaxResponse = res;
                  fileStrList.push(res.filename)
                  inputImgArray.push(res.id)
                  $('#img-input').val(inputImgArray)
                } else {
                  that.files[that.ajax.index].uploadStatus = 'error';
                  that.files[that.ajax.index].ajaxResponse = res;
                  alert('Upload failed')
                  let fileFailId = that.files[that.ajax.index].id
                  that.files.forEach(function (item, index) {
                    if (item.id == fileFailId) {
                      that.files.splice(index, 1);
                    }
                  });
                }
                that.updateFilesDom();
                that.configs.onSuccess && that.configs.onSuccess(res);
                that.upload();
              },
              error: function (err) {
                that.files[that.ajax.index].uploadStatus = 'error';
                that.files[that.ajax.index].ajaxResponse = err;
                that.updateFilesDom();
                that.configs.onError && that.configs.onError(err);
                that.upload();
              }
            });
          }

        }
      }
    }
  };
  window.easyUploader = easyUploader;
  function checkRepeat(allList, name){
    for(var i = 0; i < allList.length; i++) {
      if(allList[i] == name) {
        return true;
      }
    }
    return false;
  }
}(window, document));
