data=readcell('FEM_entire_data_set.csv');

j=1;
for i = 1:3222
    if data{i,1} == 0 & i > 1
       %fprintf('Found 0 in row %d\n',i)
        newdata(j,:) = data(i-1,:);
        j = j+1;
    end
end
T = cell2table(newdata);
newT = T(:,2:end);
writetable(newT,'myDataFile.csv')