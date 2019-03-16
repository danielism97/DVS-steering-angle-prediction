for index = 1:399
    %% load events
    events = load(strcat(strcat('events/', int2str(index)),'.mp4.txt'));
    x = events(:,1);
    y = events(:,2);
    ts = events(:,3);
    pol = events(:,4);

    %% define output frame parameters
    res_x = max(x) + 1; 
    res_y = max(y) + 1;
    delta_t = 1000000; % video length is 1s
    frames_inc = zeros(res_x, res_y);
    frames_dec = zeros(res_x, res_y);

    %% create frames
    for t = 0.1*delta_t : 0.1*delta_t : delta_t
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
        frames_inc = frames_inc + current_frame_inc;
        frames_dec = frames_dec + current_frame_dec;
    end

    %% create movie
    %output = immovie(rot90(frames));
%     imshow(rot90(frames_inc));
%     figure
%     imshow(rot90(frames_dec));
    
    %% save the frames
    frames_inc = mat2gray(rot90(frames_inc));
    frames_dec = mat2gray(rot90(frames_dec));
    imwrite(frames_inc, strcat(int2str(index+400),'_inc.png'));
    imwrite(frames_dec, strcat(int2str(index+400),'_dec.png'))
end