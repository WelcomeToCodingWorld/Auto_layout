#  navigation transition test
navigationBar.isTranslucent = true//default is true

when explicitly to set this property to true,the transition will not be  smoothly, we can see a black area their (push transition).



1:<_UIBarBackground: 0x10280a870; frame = (0 -20; 414 64); userInteractionEnabled = NO; layer = <CALayer: 0x1c402f260>>
    2:<UIImageView: 0x10280aee0; frame = (0 64; 414 0.333333); userInteractionEnabled = NO; layer = <CALayer: 0x1c402f6a0>>
    2:<UIVisualEffectView: 0x10280b100; frame = (0 0; 414 64); layer = <CALayer: 0x1c4222060>>
        3:<_UIVisualEffectBackdropView: 0x101f01180; frame = (0 0; 414 64); autoresize = W+H; userInteractionEnabled = NO; layer = <UICABackdropLayer: 0x1c0033e40>>
        3:<_UIVisualEffectSubview: 0x101f06420; frame = (0 0; 414 64); autoresize = W+H; userInteractionEnabled = NO; layer = <CALayer: 0x1c0034040>>
        3:<_UIVisualEffectSubview: 0x102805160; frame = (0 0; 414 64); alpha = 0.85; autoresize = W+H; userInteractionEnabled = NO; layer = <CALayer: 0x1c4227800>>



1:<_UIBarBackground: 0x10280a870; frame = (0 -20; 414 64); userInteractionEnabled = NO; layer = <CALayer: 0x1c402f260>>
    2:<UIImageView: 0x10280acc0; frame = (0 0; 414 64); opaque = NO; userInteractionEnabled = NO; layer = <CALayer: 0x1c402f680>>
    2:<UIImageView: 0x10280aee0; frame = (0 64; 414 0); opaque = NO; userInteractionEnabled = NO; layer = <CALayer: 0x1c402f6a0>>
