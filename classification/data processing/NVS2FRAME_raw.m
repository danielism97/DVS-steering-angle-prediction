for index = 0:399
    %% load events
    events = load(strcat(strcat('C:\Users\Duolikun Danier\Documents\Third_Year_Project\PIX2NVS_EXE_NEW\Events\', int2str(index)),'.mp4.txt'));
    x = events(:,1);
    y = events(:,2);
    ts = events(:,3);
    pol = events(:,4);

    %% define output frame parameters
    res_x = max(x) + 1; 
    res_y = max(y) + 1;
    delta_t = 1000000; % video length is 1s
    frames = zeros(res_x, res_y, 3, 10);

    %% create frames
    for t = delta_t
        current_t = ts((t-0.1*delta_t)<=ts & ts<t)';
        current_frame_inc = zeros(res_x, res_y);
        current_frame_dec = zeros(res_x, res_y);

        if size(current_t, 2) ~= 0
            index_start = find(ts == current_t(1));
            index_end = find(ts == current_t(end));

            for i = index_start(1) : index_end(end)
                if pol(i) == 1
                    current_frame_inc(x(i)+1, y(i)+1) = current_frame_inc(x(i)+1, y(i)+1) + 1;
                elseif pol(i) == 0
                    current_frame_dec(x(i)+1, y(i)+1) = current_frame_dec(x(i)+1, y(i)+1) + 1;
                end
            end
        end
        frames(:,:, 1, t/(0.1*delta_t)) = current_frame_dec;
        frames(:,:, 2, t/(0.1*delta_t)) = current_frame_inc;
    end

    %% create movie
    %output = immovie(rot90(frames));
    %implay(output);
    
    %% save the last frame
    last_frame = rot90(frames(:,:,:, 10));
    save(strcat(strcat('C:\Users\Duolikun Danier\Documents\Third_Year_Project\Data_DVS\', int2str(index)),'.mat'),'last_frame');
end