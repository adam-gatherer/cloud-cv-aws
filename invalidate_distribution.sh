#!/bin/bash
aws cloudfront list-distributions > jqfile
length=2
target="cloud-cv-aws"
for (( c=0; c<$length; c++))
do
    comment=$( cat jqfile | jq -r '.DistributionList.Items['$c'].Comment' )
    if [ "$comment" == "$target" ]
    then
        distributionId=$( cat jqfile | jq -r '.DistributionList.Items['$c'].Id')
        aws cloudfront create-invalidation \
            --distribution-id "$distributionId" \
            --paths "/index.html" "/styles.css" "/img/*" \
            --no-cli-pager
        echo "Invalidation created."
        exit 1
    else
        echo "Distribution not found!"
        exit 1
    fi
done