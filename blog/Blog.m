function Blog
    clc
    
    %% imports tidbits
    fileloc='C:\Users\ltsai\Documents\Personal\Github\LukeWebsite\LukeWebsite\blog\';
       
    source_files = dir(fullfile([fileloc,'Blog Posts\'], '*.txt'));
    initial=fileread([fileloc,'Formatting\1 Initial.txt']);
    article=fileread([fileloc,'Formatting\2 Article.txt']);
    space=fileread([fileloc,'Formatting\3 Space.txt']);
    snippet=fileread([fileloc,'Formatting\4 Snippet.txt']);
    ending=fileread([fileloc,'Formatting\5 Ending.txt']);
    output=[fileloc,'index.html'];
    
    fid = fopen(output,'w');
    fprintf(fid, '%s', initial);
    fclose(fid);
    
    fid = fopen(output,'a');
    for i = 1:length(source_files)
        clear data data2 posttitle posttags postid postlines
        disp([num2str(i),' of ',num2str(length(source_files))])
        data=fileread([fileloc,'Blog Posts\',source_files(i).name]);
        data2=char(strsplit(data,{char(13),char(10)},'CollapseDelimiters',true));
        posttitle=strtrim(data2(1,:));
        posttags=data2(2,:);
        postid=source_files(i).name(1:(length(source_files(i).name)-4));
        postlines=data2(3:end,:);
        posttext='';
        for j=1:size(postlines,1)
            if regexp(postlines(j,:), regexptranslate('wildcard','<*>'))
                posttext=strcat(posttext,postlines(j,:));
            else
                posttext=strcat(posttext,'<p class="bottom">',postlines(j,:),'</p>');
            end
        end
        post=article;
        post=strrep(post,'[id]',postid);
        post=strrep(post,'[title]',posttitle);
        post=strrep(post,'[body]',posttext);
        fprintf(fid, '%s', post);
    end
        
    fprintf(fid, '%s', space);
    
    for i = 1:length(source_files)
        clear data data2 posttitle posttags postid postlines
        disp([num2str(i),' of ',num2str(length(source_files))])
        data=fileread([fileloc,'Blog Posts\',source_files(i).name]);
        data2=char(strsplit(data,{char(13),char(10)},'CollapseDelimiters',true));
        posttitle=strtrim(data2(1,:));
        posttags=data2(2,:);
        postid=source_files(i).name(1:(length(source_files(i).name)-4));
        post=snippet;
        post=strrep(post,'[id]',postid);
        post=strrep(post,'[title]',posttitle);
        post=strrep(post,'[tag]',posttags);
        post=strrep(post,'[body-snippet]',strtrim(data2(3,:)));
        fprintf(fid, '%s', post);
    end
    
    
    fprintf(fid, '%s', ending);
    fclose(fid);

    disp("Done")
end