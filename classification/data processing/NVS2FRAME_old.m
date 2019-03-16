for i = 1:1:399 %0:1:399
    events = load(strcat(strcat('C:\Users\Duolikun Danier\Documents\Third_Year_Project\PIX2NVS_EXE\Events\', int2str(i)),'.mp4.txt'));
    x = events(:,1);
    y = events(:,2);
    ts = events(:,3);
    pol = events(:,4);
    output = displayDVSdata(x,y,pol,ts, 'fps', int32(6))
    imwrite(output(end).cdata, strcat(strcat('C:\Users\Duolikun Danier\Documents\Third_Year_Project\Data_DVS\', int2str(i)),'.png'));
end
