---
title: Qt
date: 2021-01-06 16:13:51
tags: [qt]
published: false
---

##### Qt MultiMedia
qt 多媒体模块介绍
类名	英文描述	中文描述
|类名|英文描述|中文描述|
|:-|:-:|:-:|
|a|2|3|

>|QAudioBuffer|Represents a collection of audio samples with a specific format and sample rate|表示具有特定格式和采样率的音频样本的集合|
>QAudioBuffer::StereoFrame|	Simple wrapper for a stereo audio frame	|立体声音频框架的简单包装|

|QAudioDecoder	|Allows decoding audio	允许解码音频|
|QAudioDeviceInfo	|Interface to query audio devices and their functionality	|用于查询音频设备及其功能的接口|
|QAudioFormat	|Stores audio stream parameter information	存储音频流参数信息|
|QAudioInput	|Interface for receiving audio data from an audio input device	|用于从音频输入设备接收音频数据的接口|
|QAudioOutput|Interface for sending audio data to an audio output device	|用于将音频数据发送到音频输出设备的接口|
|QAudioProbe|Allows you to monitor audio being played or recorded	|允许您监视正在播放或录制的音频|
||QAbstractAudioDeviceInfo	|Base class for audio backends	|音频后端的基础类|
QAbstractAudioInput	Access for |QAudioInput to access the audio device provided by the plugin	|访问QAudioInput访问插件提供的音频设备|
|QAbstractAudioOutput	|Base class for audio backends	|音频后端的基础类|
||QAudioSystemPlugin	|Abstract base for audio plugins	|音频插件抽象基础|
|QSound	|Method to play .wav sound files	|播放.wav声音文件的方法|
|QSoundEffect	|Way to play low latency sound effects	|播放低延时音效的方式|
|QCamera::FrameRateRange	|A FrameRateRange represents a range of frame rates as minimum and maximum rate	|FrameRateRange表示帧速率的范围为最小和最大速率|
|QCamera	|Interface for system camera devices	|系统相机设备接口|
|QCameraExposure	|Interface for exposure related camera settings	|曝光相关摄像机设置界面|
|QCameraFocus	|Interface for focus and zoom related camera settings	|用于对焦和变焦相关设置的界面|
|QCameraFocusZone	|Information on zones used for autofocusing a camera	|关于用于自动对焦相机的区域的信息|
|QCameraImageProcessing	|Interface for image processing related camera settings	|图像处理相关摄像机设置界面|
|QCameraInfo	|General information about camera devices	|有关相机设备的一般信息|
|QCameraViewfinderSettings	|Set of viewfinder settings	|设置取景器设置|
|QAudioDecoderControl	|Access to the audio decoding functionality of a QMediaService	|访问QMediaService的音频解码功能|
|QAudioEncoderSettingsControl	|Access to the settings of a media service that performs audio encoding	|访问执行音频编码的媒体服务的设置|
|QAudioInputSelectorControl	|Audio input selector media control	|音频输入选择器媒体控制|
|QAudioOutputSelectorControl	|Audio output selector media control	|音频输出选择器媒体控制|
|QAudioRoleControl	|Control over the audio role of a media object	|控制媒体对象的音频角色|
|QCameraCaptureBufferFormatControl	|Control for setting the capture buffer format	|用于设置捕获缓冲区格式的控制|
|QCameraCaptureDestinationControl	|Control for setting capture destination	|控制设置捕获目的地|
|QCameraControl	|Abstract base class for classes that control still cameras or video cameras	|用于控制静态相机或摄像机的类的抽象基类|
|QCameraExposureControl	|Allows controlling camera exposure parameters	|允许控制相机曝光参数|
|QCameraFeedbackControl	|Allows controlling feedback (sounds etc) during camera operation	|允许在相机操作期间控制反馈（声音等）|
|QCameraFlashControl	|Allows controlling a camera's flash	|允许控制相机的闪光灯|
|QCameraFocusControl	|Supplies control for focusing related camera parameters	|用于控制相关的相机参数|
|QCameraImageCaptureControl	|Control interface for image capture services	|图像捕获服务控制界面|
|QCameraImageProcessingControl	|Abstract class for controlling image processing parameters, like white balance, contrast, saturation, sharpening and denoising	|用于控制图像处理参数的抽象类，如白平衡，对比度，饱和度，锐化和去噪|
|QCameraInfoControl	|Camera info media control	|相机信息媒体控制|
|QCameraLocksControl	|Abstract base class for classes that control still cameras or video cameras	|用于控制静态相机或摄像机的类的抽象基类|
|QCameraViewfinderSettingsControl	|Abstract class for controlling camera viewfinder parameters	|用于控制摄像机取景器参数的抽象类|
|QCameraViewfinderSettingsControl2	|Access to the viewfinder settings of a camera media service	|访问摄像机媒体服务的取景器设置|
|QCameraZoomControl	|Supplies control for optical and digital camera zoom	|用于光学和数码相机变焦的耗材控制|
|QImageEncoderControl	|Access to the settings of a media service that performs image encoding	|访问执行图像编码的媒体服务的设置|
|QMediaAudioProbeControl	|Allows control over probing audio data in media objects	|允许控制媒体对象中的探测音频数据|
|QMediaAvailabilityControl	|Supplies a control for reporting availability of a service	|提供报告服务可用性的控制|
|QMediaContainerControl	|Access to the output container format of a QMediaService	|访问QMediaService的输出容器格式|
|QMediaGaplessPlaybackControl	|Access to the gapless playback related control of a QMediaService	|访问无缝播放相关控件的QMediaService|
|QMediaNetworkAccessControl	|Allows the setting of the Network Access Point for media related activities	|允许为媒体相关活动设置网络接入点|
|QMediaPlayerControl	|Access to the media playing functionality of a QMediaService	|访问QMediaService的媒体播放功能|
|QMediaRecorderControl	|Access to the recording functionality of a QMediaService	|访问QMediaService的录制功能|
|QMediaStreamsControl	|Media stream selection control	|媒体流选择控制|
|QMediaVideoProbeControl	|Allows control over probing video frames in media objects	|允许控制媒体对象中的探测视频帧|
|QMetaDataReaderControl	|Read access to the meta-data of a QMediaService's media	|读取对QMediaService媒体元数据的访问权限|
|QMetaDataWriterControl	|Write access to the meta-data of a QMediaService's media	|写入对QMediaService媒体元数据的访问|
|QRadioDataControl	|Access to the RDS functionality of the radio in the QMediaService	|访问QMediaService中无线电的RDS功能|
|QRadioTunerControl	|Access to the radio tuning functionality of a QMediaService	|访问QMediaService的无线电调谐功能|
|QVideoDeviceSelectorControl	|Video device selector media control	|视频设备选择器媒体控制|
|QVideoEncoderSettingsControl	|Access to the settings of a media service that performs video encoding	|访问执行视频编码的媒体服务的设置|
|QVideoRendererControl	|Media control for rendering video to a QAbstractVideoSurface	|媒体控制，用于将视频渲染到QAbstractVideoSurface|
|QVideoWindowControl	|Media control for rendering video to a window	|用于将视频渲染到窗口的媒体控制|
|QMediaContent	|Access to the resources relating to a media content	|访问与媒体内容相关的资源|
|QMediaPlayer	|Allows the playing of a media source	|允许播放媒体源|
|QMediaPlaylist	|List of media content to play	|要播放的媒体内容列表|
|QMediaResource	|Description of a media resource	|媒体资源的描述|
|QMediaBindableInterface	|The base class for objects extending media objects functionality	|扩展媒体对象功能的对象的基类|
|QMediaControl	|Base interface for media service controls	|媒体服务控制的基本界面|
|QMediaObject	|Common base for multimedia objects	|多媒体对象的共同基础|
|QMediaService	|Common base class for media service implementations	|媒体服务实现的通用基类|
|QMediaServiceCameraInfoInterface	|Interface provides camera-specific information about devices supported by a camera service plug-in	|接口提供有关相机服务插件支持的设备的相机特定信息|
|QMediaServiceDefaultDeviceInterface	|Interface identifies the default device used by a media service plug-in	|接口标识介质服务插件使用的默认设备|
|QMediaServiceFeaturesInterface	|Interface identifies features supported by a media service plug-in	|接口识别媒体服务插件支持的功能|
|QMediaServiceProviderPlugin	|Interface provides an interface for QMediaService plug-ins	|接口为QMediaService插件提供了一个接口|
|QMediaServiceSupportedDevicesInterface	Interface identifies the devices supported by a media service plug-in	|接口标识媒体服务插件支持的设备|
|QMediaServiceSupportedFormatsInterface	|Interface identifies if a media service plug-in supports a media format	|接口识别媒体服务插件是否支持媒体格式|
|QMediaTimeInterval	|Represents a time interval with integer precision	|表示整数精度的时间间隔|
|QMediaTimeRange	|Represents a set of zero or more disjoint time intervals	|表示一组零个或多个不相交的时间间隔|
|QRadioData	|Interfaces to the RDS functionality of the system radio	|与系统无线电的RDS功能的接口|
|QRadioTuner	|Interface to the systems analog radio device	|与系统模拟无线电设备的接口|
|QAudioRecorder	|Used for the recording of audio	|用于录制音频|
|QAudioEncoderSettings	|Set of audio encoder settings	|音频编码器设置|
|QImageEncoderSettings	|Set of image encoder settings	|设置图像编码器设置|
|QVideoEncoderSettings	|Set of video encoder settings	|视频编码器设置集|
|QMediaRecorder	|Used for the recording of media content	|用于录制媒体内容|
|QAbstractPlanarVideoBuffer	|Abstraction for planar video data	|平面视频数据的抽象|
|QAbstractVideoBuffer	|Abstraction for video data	|视频数据抽象|
|QAbstractVideoFilter	|Represents a filter that is applied to the video frames received by a VideoOutput type	|表示应用于VideoOutput类型接收到的视频帧的过滤器|
|QVideoFilterRunnable	|Represents the implementation of a filter that owns all graphics and computational resources, and performs the actual filtering or calculations	|表示具有所有图形和计算资源的过滤器的实现，并执行实际的过滤或计算|
|QAbstractVideoSurface	|Base class for video presentation surfaces	|视频演示表面的基类|
|QVideoFrame	|Represents a frame of video data	|表示一帧视频数据|
|QVideoProbe	|Allows you to monitor video frames being played or recorded	|允许您监视正在播放或录制的视频帧|
|QVideoSurfaceFormat	|Specifies the stream format of a video presentation surface	|指定视频演示表面的流格式|
|