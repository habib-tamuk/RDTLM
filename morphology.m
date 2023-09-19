a1 = bwmorph(cout_medFilter,'bothat');
a2 = bwmorph(cout_medFilter,'branchpoints');
a3 = bwmorph(cout_medFilter,'bridge');
a4 = bwmorph(cout_medFilter,'clean');
a5 = bwmorph(cout_medFilter,'close');
a6 = bwmorph(cout_medFilter,'diag');
a7 = bwmorph(cout_medFilter,'dilate');
a8 = bwmorph(cout_medFilter,'erode');
a9 = bwmorph(cout_medFilter,'fill');
a10 = bwmorph(cout_medFilter,'hbreak');
a11 = bwmorph(cout_medFilter,'endpoints');
a12 = bwmorph(cout_medFilter,'majority');
a13 = bwmorph(cout_medFilter,'open');
a14 = bwmorph(cout_medFilter,'remove');
a15 = bwmorph(cout_medFilter,'shrink', Inf);
a16 = bwmorph(cout_medFilter,'skel', Inf);
a17 = bwmorph(cout_medFilter,'spur');
a18 = bwmorph(cout_medFilter,'thicken', Inf);
a19 = bwmorph(cout_medFilter,'thin', Inf);
a20 = bwmorph(cout_medFilter,'tophat');
%%
subplot(411), montage({a1,a2,a3,a4,a5}, 'size',[1 5]);
subplot(412), montage({a6,a7,a8,a9,a10}, 'size',[1 5]);
subplot(413), montage({a11,a12,a13,a14,a15}, 'size',[1 5]);
subplot(414), montage({a16,a17,a18,a19,a20}, 'size',[1 5]);
%%
figure, montage({cout_medFilter,a11,a14,a15,a16,a19}, 'size',[1 6]);