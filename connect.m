
t = tcpip('localhost', ******, 'NetworkRole', 'server');
fopen(t);
disp('Server is ready.');

% 读取数据并处理
while true
    if t.BytesAvailable > 0
        data = fscanf(t, '%s');
        fprintf('Received data: %s\n', data);
        % 调用处理数据函数
        processRealTimeData(str2num(data));
    end
    pause(0.1);  % 延迟
end


fclose(t);
delete(t);
clear t;
