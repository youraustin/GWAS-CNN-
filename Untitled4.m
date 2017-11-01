readmap;

load mydata;

[row1, column1]=size(lab_snp);
[row2, column2]=size(map_dataset.textdata);

locaX=zeros(column1,1);
locaY=zeros(column1,1);
datamap=cell(column1,2);

for k=1:column1
    %% [u,v]=find(strcmp(ImageMap, GenoNameReliefF(1,k)));
    snp=lab_snp(1, k);
    [u,v]=find(strcmp(map_dataset.textdata, lab_snp(1, k)));
    locaX(k,1)=u;
    locaY(k,1)=v;
end

for i=1:column1
    datamap(i,1)=mapdataset.textdata(locaX(i,1),1);
    datamap(i,2)=mapdataset.textdata(locaX(i,1),2);
end