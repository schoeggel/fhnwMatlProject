try

DEBUG=false;
DISPLAY=true;

if DEBUG
    scores=[1074789887 1074793677 1074790759 1074790525 1074787677 1074790207 1074787915 1074790375 1074790215 1074794453 1074790545 1074789909 1074793691 1074790129 1074790295 1074790083 1074790861 1074788851 1074789439 1074789589 1074790043 1074794297 1074790237 1074791011];
else 
    % reads current state
    url='http://www.mathworks.com/matlabcentral/cody/problems/1910-blockland/solutions/map?sort=&term=status%3ACorrect';
    s=urlread(url);
    
    % reads scores
    idx1=findstr(s,'solutions: [{');
    if isempty(idx1), idx1=1; else idx1=idx1(1); end
    idx2=idx1+findstr(s(idx1+1:end),'}]');
    if isempty(idx2), idx2=numel(s); else idx2=idx2(1); end
    str=regexp(s(idx1:idx2),'"id":(\d+),"metric":(\d{10}),"status":"Correct"','tokens');
    str=str(cellfun('length',str)==2);
    scores=str2double(cellfun(@(x)x{2},str,'uni',0));
    ids=str2double(cellfun(@(x)x{1},str,'uni',0));
end
% decodes block positions
if isempty(scores), coding=char(zeros(0,32)); 
else coding=dec2bin(scores,32); 
end
header=coding(:,1:3); % fixed header (3 bits)
state=coding(:,4:11); % checksum: mod(last valid entry score,256) (8 bits)
posit=coding(:,12:31);% position: round(position*1000)+2^19 (20 bits)
check=coding(:,32);   % check-stability (future use) (1 bit)
valid=find(all(bsxfun(@eq,header,'010'),2)); 
state=bin2dec(state(valid,:)); 
posit=bin2dec(posit(valid,:));
check=bin2dec(check(valid,:));
X=[];
prevstate=0;
for i=1:size(posit,1)
    if state(i)==prevstate,
        prevstate=mod(posit(i),256);
        X=[X (posit(i)-2^19)/1000];
    end
end

x=X(:)';
N=numel(x);
y=zeros(size(x));
for n=1:N, y(n)=max([0 y(abs(x(1:n-1)-x(n))<1)+1]); end

% display
if DISPLAY
    clf;
    night=mod(str2num(datestr(now,'HH'))-4,24);
    night=max(.05,2.5*min(night,24-night)/12-.5);
    xlim=[min(-10,min([0 x])-1) max(10,max([0 x])+2)];
    ylim=max([diff(xlim),max(y)+1])*1.25;
    scale=50/ylim;
    
    % blocks
    seed=rand('seed');
    rand('seed',0);
    arrayfun(@(x,y)patch(x+[0,1,1,0],y+[0,0,1,1],zeros(1,4),'k','facecolor',rand(1,3)*min(1,.25+.5*night),'edgecolor','k'),x,y,'uni',0);
    rand('seed',1e6*rem(now,1));
    randn('seed',1e6*rem(now,1));
    
    % floor
    patch(xlim*[1,0,0,1;0,1,1,0],[0,0,-1,-1],'k','facecolor',[0,0,0],'edgecolor','none');
    
    % sky
    height=(0:255)/256;
    colorheight=max(0,min(1,night/2+night*(.25+1*[1.5-3*height'/scale,1.5-2*height'/scale,.5-.8*height'/scale])))*diag([.9,.9,1]);
    arrayfun(@(n)patch(xlim(1)+diff(xlim)*[0 1 1 0],ylim*height(n)+ylim/numel(height)*[0 0 1 1]*1.1,-100+zeros(1,4),'r','facecolor',colorheight(n,:),'edgecolor','none'),1:numel(height),'uni',0); 
    
    % clouds
    hold on;
    a=linspace(0,2*pi,64); 
    for m=1:randi([0,ceil(10/scale)])
        nh=min(numel(height),round(scale*numel(height)/2*(1+.5*rand)));
        x0=[-10+20*rand;ylim*height(nh)];
        c0=.05*rand;
        %c0=(.8+.1*rand);
        for n=1:20, 
            xt=x0+scale*[2;.5].*randn(2,1);
            cx=scale*diag([1+1*rand;1])*orth(randn(2))*[cos(a);sin(a)]; 
            patch(xt(1)+cx(1,:),xt(2)+cx(2,:),n/1e2-97+m+zeros(1,size(cx,2)),'w','facecolor',min(1,colorheight(nh,:)+c0),'edgecolor','none'); 
            cx=cx(:,1:randi([16,32]));  cx=[cx fliplr(cx*.95)];
            h=patch(xt(1)+cx(1,:),xt(2)+cx(2,:),(n+.5)/1e2-97+m+zeros(1,size(cx,2)),'w','facecolor',max(0,min(1,colorheight(nh,:)+c0)-rand*.1),'edgecolor','none');
        end
    end
    hold off;
    
    % moon
    a=linspace(0,2*pi,256);
    nh=min(numel(height),round(scale*numel(height)/2*(.5+1*rand)));
    x0=[-10+20*rand;ylim*height(nh)];
    ang=randn*pi/32;
    ph=1-2*rand;
    c0=(.5+.25*rand)*[cos(ang) sin(ang);-sin(ang) cos(ang)];
    cx=c0*scale*[cos(a);sin(a)];
    patch(x0(1)-cx(2,:),x0(2)+cx(1,:),zeros(1,size(cx,2))-98,'k','facecolor',colorheight(nh,:),'edgecolor','none');
    cx=scale*[cos(a(1:end/2));sin(a(1:end/2))];
    for n=1:-.1:0
        cx1=c0*[cx diag([1 max(-1,ph-.2*n)])*fliplr(cx)];
        patch(x0(1)-cx1(2,:),x0(2)+cx1(1,:),zeros(1,size(cx1,2))-97.9-n/20,'w','facecolor',(1-n)*[1 1 1]+n*colorheight(nh,:),'edgecolor','none');
    end
    
    % stars
    hold on; 
    arrayfun(@(y)plot3(xlim(1)+diff(xlim)*rand,ylim*y,-99,'.','color',max(rand(1,3),colorheight(ceil(y*size(height,1)),:)),'markersize',round(1+7*rand.^5)),rand(1,10*max(y)),'uni',0); 
    hold off;

    set(gcf,'color','w');
    axis equal tight;
    set(gca,'xlim',xlim);%,'ylim',[0,ylim]);
    title({sprintf('Snapshot from Blockland (%s)',datestr(now-4/24,'HHPM')),[datestr(now-4/24),' GMT-4']},'fontsize',14);
    set(gca,'units','norm','position',[0,0,1,.9]);axis off;

    %reshapes window
    k=max(.5,diff(get(gca,'xlim'))/diff(get(gca,'ylim')));
    set(gcf,'units','norm','position',[0,0,min(1,k),min(1,1/k)]);
end

disp('ok');
catch
disp('not ok');
end