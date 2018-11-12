
```python
data vday;
do n=1 to 6283*16;
t=n/10000;
x=16*sin(t)*sin(t)*sin(t);
y=13*cos(t)-5*cos(2*t)-2*cos(3*t)-cos(4*t);
output;
end;
run;
goptions colors=(pink);

proc gplot data=vday ;
plot y*x;
run;
```

![image](http://upload-images.jianshu.io/upload_images/8699364-3d51b8e19e7e24fb.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)



The SAS Code is originated from Joe Wang . 

