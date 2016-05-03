DATASET = {
    'cocaine173.mat';
    'cocaine174.mat';
    'cocaine175.mat';
    'cocaine177.mat';
    'cocaine178.mat';
    'control181.mat';
    'control182.mat';
    'control189.mat';
    'control239.mat';
    'control258.mat';
    'fear187.mat';
    'fear188.mat';
    'fear197.mat';
    'fear199.mat';
    'fear200.mat';
};
HISTFILE = 'histograms.mat';
if exist(HISTFILE, 'file')==0
    fh = matfile(HISTFILE, 'Writable', true);
    fh.histograms = zeros(1000,15,2);
    for i=1:15
        disp(DATASET(i));
        fd = matfile(char(DATASET(i)));
        [N,E] = histcounts(fd.clarity_volume,'BinMethod','integers');
        X = (E(2:end)+E(1:end-1))/2;
        N = N(10:end);  % remove background counts
        X = X(10:end);
        [m, mi] = max(N);
        if mi-500 < 1  % avoid negetive indices
            s = 1;
        else
            s=mi-500;
        end
        e=s+999;
        disp([s,e]);
        disp([i,m,mi]);
        fh.histograms(1:1000,i,1) = transpose(N(s:e));
        fh.histograms(1:1000,i,2) = transpose(X(s:e));
        
    end
else
    fh = matfile(HISTFILE);
end

% plot
f = figure();
hold on;
for i=1:5
    p1=plot(fh.histograms(:,i,2),fh.histograms(:,i,1),'r');
end
for i=6:10
    p2=plot(fh.histograms(:,i,2),fh.histograms(:,i,1),'g');
end
for i=11:15
    p3=plot(fh.histograms(:,i,2),fh.histograms(:,i,1),'b');
end
hold off;
grid();
axis([90 140 0 3.1e8]);
title('.tif Dataset Histograms');
xlabel('Values');
ylabel('Counts');
legend([p1,p2,p3],'cocaine','control','fear');
